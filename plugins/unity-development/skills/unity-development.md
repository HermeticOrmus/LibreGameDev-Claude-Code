# Unity development pattern library

Reference patterns for Unity 6 development. Use as lookup.

## Architecture decision tree

```
Project type: 2D? 3D? Mixed?
  Pick Render Pipeline: URP (most), HDRP (high-end), Built-in (legacy maintenance only)

Entity count at peak: < 100? 100-1000? > 1000?
  < 100: MonoBehaviour everywhere
  100-1000: MonoBehaviour with pooling
  > 1000: Consider ECS/DOTS — does team have experience?

Multiplayer?
  No: skip
  Cooperative / co-op: Netcode for GameObjects (current Unity recommendation)
  Competitive < 16 players: Netcode for GameObjects or Mirror
  Competitive 16+ players: dedicated server architecture, possibly DOTS for sim

Platform mix:
  PC only: easiest, no compromise
  PC + mobile: bake compromises in early (texture sizes, shader complexity)
  Console: budget for cert (3+ months); platform-specific work isolated to per-platform modules
  WebGL: GC pauses are devastating; profile early
```

## Render Pipeline migration recipes

### Built-in → URP

1. Install URP via Package Manager
2. Create URP Asset (right-click → Create → Rendering → URP Asset)
3. Project Settings → Graphics → Scriptable Render Pipeline Settings: drag URP Asset
4. Window → Rendering → Render Pipeline Converter (Unity 6 has automated converter)
5. Migrate custom shaders to Shader Graph or rewrite as URP-compatible HLSL
6. Verify post-processing — old PostProcessing Stack v2 replaced by URP Volume system

### Built-in → HDRP

Heavier lift. Materials rebuild, lighting re-bake, custom shaders rewritten. Allocate weeks for a small project, months for a large one.

### Custom shader patterns

```hlsl
// URP unlit shader skeleton
Shader "Custom/MyUnlit"
{
    Properties { _MainTex ("Texture", 2D) = "white" {} }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            struct Attributes { float4 positionOS : POSITION; float2 uv : TEXCOORD0; };
            struct Varyings { float4 positionHCS : SV_POSITION; float2 uv : TEXCOORD0; };
            Varyings vert(Attributes IN) {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }
            half4 frag(Varyings IN) : SV_Target { return tex2D(_MainTex, IN.uv); }
            ENDHLSL
        }
    }
}
```

## Addressables migration recipe

```csharp
// Old (Resources)
GameObject prefab = Resources.Load<GameObject>("Enemies/Drone");
GameObject instance = Instantiate(prefab);

// New (Addressables, async)
[SerializeField] private AssetReference droneRef;

private async void SpawnDrone()
{
    GameObject prefab = await droneRef.LoadAssetAsync<GameObject>().Task;
    GameObject instance = Instantiate(prefab);
    // Track instance for later Addressables.Release
}

// New (Addressables, by key)
private async void SpawnByKey()
{
    GameObject prefab = await Addressables.LoadAssetAsync<GameObject>("Drone").Task;
    GameObject instance = Instantiate(prefab);
}
```

Always pair `LoadAssetAsync` with `Release`. Without release, the asset stays in memory.

## Input System patterns

### Pattern: PlayerInput component

```csharp
[RequireComponent(typeof(PlayerInput))]
public class Player : MonoBehaviour
{
    private PlayerInput _input;
    private InputAction _move;

    private void Awake()
    {
        _input = GetComponent<PlayerInput>();
        _move = _input.actions["Move"];
    }

    private void OnEnable() { _move.performed += OnMove; }
    private void OnDisable() { _move.performed -= OnMove; }

    private void OnMove(InputAction.CallbackContext ctx) { /* ... */ }
}
```

### Pattern: InputActionAsset reference

```csharp
[SerializeField] private InputActionAsset inputActions;
private InputAction _move;

private void OnEnable()
{
    _move = inputActions.FindAction("Player/Move");
    _move.Enable();
}
```

### Pattern: Runtime rebinding

```csharp
private void StartRebinding(InputAction action, int bindingIndex)
{
    action.Disable();
    action.PerformInteractiveRebinding(bindingIndex)
        .OnComplete(operation =>
        {
            action.Enable();
            operation.Dispose();
        })
        .Start();
}
```

## DOTS / ECS quick reference

```csharp
// Define a component
public struct Velocity : IComponentData { public float3 Value; }

// Define a system
public partial struct MovementSystem : ISystem
{
    public void OnUpdate(ref SystemState state)
    {
        float deltaTime = SystemAPI.Time.DeltaTime;
        foreach (var (transform, velocity) in SystemAPI.Query<RefRW<LocalTransform>, RefRO<Velocity>>())
        {
            transform.ValueRW.Position += velocity.ValueRO.Value * deltaTime;
        }
    }
}
```

DOTS pays off when:
- 1000+ entities updating per frame
- Burst-compiled jobs can vectorize the math
- Determinism is required

Doesn't pay off:
- < 1000 entities
- Logic is event-driven, not iterative
- Team doesn't have ECS experience

## Common mistakes catalog

### "Performance tanked when I added many enemies"

Profile first. Common culprits:

1. **Find / FindObjectsOfType** in Update → O(n) per call per frame
2. **Instantiate / Destroy without pooling** → GC pauses
3. **Many small scripts each with Update** → Update call overhead
4. **`Rigidbody.velocity = X` in Update** → use FixedUpdate
5. **Per-frame string concatenation** → allocate hell

### "Build is huge"

Check Build Report (Window → Analysis → Build Report). Common bloat:

- Resources folder containing assets that aren't used
- Textures at max-quality on mobile
- Shader variants ballooning (every #pragma multi_compile multiplies variants)
- Editor-only assets accidentally in build

### "WebGL build runs slow / has GC stutter"

WebGL specific:

- No threading (background work blocks main thread)
- GC pauses are devastating; pooling is essential
- Texture compression different per browser
- Audio constraints (no MP3 in some browsers)

### "Scene loading freezes the game"

Use async loading:

```csharp
SceneManager.LoadSceneAsync("Level2", LoadSceneMode.Single);
```

If still freezing, the assets in the scene are loading synchronously. Use Addressables with explicit load + scene activation:

```csharp
var op = Addressables.LoadSceneAsync("Level2");
op.Completed += handle => SceneManager.SetActiveScene(handle.Result.Scene);
```

### "Domain reload makes Play mode slow"

Project Settings → Editor → Enter Play Mode Options: enable, then disable "Reload Domain" and "Reload Scene." 5-10× faster Play mode iteration. Re-enable for CI builds.

### "Coroutine fires twice / never stops"

Coroutines stay active until `StopCoroutine` or the GameObject is disabled / destroyed. If you start a coroutine in `OnEnable` without storing the handle, you can't stop it.

```csharp
private Coroutine _routine;

private void OnEnable() { _routine = StartCoroutine(MyRoutine()); }
private void OnDisable() { if (_routine != null) StopCoroutine(_routine); }
```

## Project structure conventions

```
Assets/
├── Scripts/           # All C# scripts
├── Scenes/            # .unity files
├── Prefabs/           # Reusable GameObjects
├── Materials/         # Materials + shaders
├── Textures/          # Source textures
├── Models/            # 3D models (.fbx, .obj)
├── Audio/             # Audio clips
├── ScriptableObjects/ # Data assets (configs, item defs)
├── Addressables/      # Addressable groups (or just mark assets)
└── Editor/            # Editor-only scripts (custom Inspectors, tools)

Packages/
└── manifest.json      # Package dependencies
```

## Cross-references

- See `docs/08-game-engines/` for cross-engine comparison
- See `docs/09-advanced-patterns/` for ECS, data-oriented design patterns
- See `docs/10-performance-optimization/` for profiling and Unity Profiler patterns
- See `docs/12-deployment-distribution/` for build pipeline + platform-specific deployment
