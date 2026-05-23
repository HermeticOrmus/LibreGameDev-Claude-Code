# Troubleshooting

Common scenarios when using LibreGameDev plugins, plus the game-dev debug patterns you'll hit regardless of the bundle.

## Plugin issues

### Plugins copied but Claude Code doesn't see them

```bash
ls ~/.claude/plugins/ | grep -c '^libre-gamedev-'
```

Should print 20. If not, re-run `./setup.sh`. If commands aren't recognized after install: restart Claude Code.

### Agent gives generic answers, not engine-specific

As of v0.2, three plugins are depth-complete: `godot-development`, `unity-development`, `multiplayer-networking`. The rest are shell-improved (better than templated but not yet full depth). See [CHANGELOG.md](CHANGELOG.md) maturity matrix.

If a depth-complete plugin gives generic answers, file an issue with the exact prompt + response.

## Game-dev scenarios the agents help with

### "Frame rate drops when I spawn many bullets / particles / enemies"

Almost always GC pressure from constant allocation. The `game-architecture` agent recommends object pooling proactively because this is the #1 cause of game performance issues.

Pattern:

```gdscript
# Bad
func _on_shoot():
    var bullet = Bullet.instantiate()
    add_child(bullet)
    # Later: bullet.queue_free() → GC eventually → frame hitch

# Good
func _on_shoot():
    var bullet = bullet_pool.get_inactive()
    if bullet:
        bullet.reset_at(player.position, mouse_direction)
        bullet.set_process(true)
```

### "Physics behaves differently between play sessions"

Non-deterministic physics. Two common causes:

1. Variable-timestep physics. Use `_physics_process` (fixed 60Hz) not `_process` (variable).
2. Reading input in `_process` and writing physics in `_physics_process` — adds frame-rate-dependent input latency. Buffer input in `_unhandled_input`.

### "Multiplayer game has rubber-banding"

Network layer issue. The `multiplayer-networking` agent walks the diagnosis:

- No client-side prediction → every input waits for server round-trip → feels laggy
- Client-side prediction but no reconciliation → predictions diverge from server → rubber-band on resync
- Variable network conditions + lockstep → slowest peer holds everyone back

Fix sequence: add prediction → add reconciliation → switch to rollback if input matters (fighting games, fast platformers)

### "Save file from old version breaks new version"

Save versioning wasn't included from Day 1. Two fixes:

1. **Always include a version field**, even in v1.0.0:
   ```json
   {"version": 1, "data": {...}}
   ```
2. **Migration functions per version**: `migrate_v1_to_v2(data)`, `migrate_v2_to_v3(data)`. Run in sequence on load.

The `/save` agent designs this from the start when asked.

### "AI feels dumb / repetitive"

Likely a FSM (Finite State Machine) being asked to do behaviors it can't express. The `/game-ai` agent recommends graduating to Behavior Trees when:

- The FSM has > 8 states
- States have > 3 outgoing transitions
- Behaviors need to be composable across enemy types

See `docs/04-game-ai/behavior-trees.md` for the full pattern.

### "Game runs fine on my machine, terrible on the target hardware"

Profile on target, not on dev machine. The `/perf-game` agent insists on measurement before optimization.

Common culprits per platform:

- **PC**: GPU shader compilation hitches (preload shaders!), draw call count, mip-level streaming
- **Mobile**: overdraw (translucent UI on top of opaque sprite), texture memory bandwidth, thermal throttling on long sessions
- **Console**: each platform has its own profiler; learn the platform-specific one. Cert is real.
- **Web (HTML5)**: garbage collection pauses are the worst (force pooling); WebGL state changes are expensive

### "Audio cuts out / clicks / pops"

Common causes:

- Too many simultaneous sounds → exceeds mixer voice limit. Set up a priority system.
- Loading audio in main thread → blocks frame → audio buffer underruns. Stream long audio.
- Sample rate mismatch between source and engine → resampling artifacts. Pre-resample at import.

The `/audio` agent diagnoses these.

### "Shader compiles but renders wrong"

Tell the `/shader` agent your engine, the actual shader code, and what you see vs. what you expected. The agent will walk:

- Vertex output → fragment input must match (interpolators)
- Coordinate spaces: world, object, view, clip, screen — easy to mix
- Sample inputs must be normalized to [0,1] if material expects them that way
- Alpha blending vs. additive blending — pick consciously, not by accident

### "Game crashes in the field but not in development"

Crash differences between dev and prod usually come from:

- Debug-build asserts catching what release builds silently ignore
- Different memory allocators (debug has guard bytes)
- Different optimization disabling/enabling certain hardware behaviors
- Platform-specific code paths only hit on real devices

Strategy: ship dev-build telemetry (with assert breadcrumbs) from your first betas onward. The `/playtest` agent designs this.

## Engine-specific gotchas

### Godot 4

- Signals are async by default — chained signals can fire in non-obvious order
- `@onready` runs in node-tree order; if your script depends on a sibling, it might not exist yet
- Resources are shared by default — duplicate before modifying or all instances change
- Auto-import settings on textures override your manual edits if you save the .import file wrong

### Unity 6

- `MonoBehaviour.Start()` vs. `Awake()` ordering matters across scenes
- Addressables vs. Resources vs. AssetBundles — three different content systems, easy to mix
- URP vs. HDRP vs. Built-in — incompatible shader sets; choose at project start
- Domain reload on play can be very slow; disable in Project Settings → Editor for faster iteration

### Unreal 5

- Blueprints + C++ split — pick what lives where at project start
- World Partition vs. World Composition — different paradigms for open worlds
- Lumen + Nanite work great together; using only one is suboptimal
- Replication graph for multiplayer at scale (> 50 players) — not default, must configure

## When to file an issue

- A depth-complete plugin gives templated / generic answers — include the prompt
- A `setup.sh` flag doesn't behave as documented
- Translation requests for learning paths
- New genre or platform you'd like covered (open an issue first, discuss before PR)

See [CONTRIBUTING.md](CONTRIBUTING.md) for the issue template.
