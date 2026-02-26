# Unity Patterns

## MonoBehaviour Component Pattern

```csharp
// Well-structured MonoBehaviour: serialized fields, cached references, event lifecycle
using UnityEngine;

[RequireComponent(typeof(Rigidbody), typeof(Collider))]
public class PlayerController : MonoBehaviour
{
    [Header("Movement")]
    [SerializeField] private float _moveSpeed = 6f;
    [SerializeField] private float _jumpForce = 8f;

    [Header("Ground Check")]
    [SerializeField] private LayerMask _groundMask;
    [SerializeField] private Transform _groundCheck;
    [SerializeField] private float _groundCheckRadius = 0.2f;

    // Cached component references - filled in Awake, never in Update
    private Rigidbody _rb;
    private bool _isGrounded;
    private Vector2 _moveInput;

    private void Awake()
    {
        _rb = GetComponent<Rigidbody>();
    }

    private void OnEnable()
    {
        // Subscribe to input or events here
    }

    private void OnDisable()
    {
        // Unsubscribe here - prevents memory leaks
    }

    private void Update()
    {
        _moveInput = new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical"));
        _isGrounded = Physics.CheckSphere(_groundCheck.position, _groundCheckRadius, _groundMask);

        if (_isGrounded && Input.GetButtonDown("Jump"))
        {
            _rb.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
        }
    }

    private void FixedUpdate()
    {
        // Physics forces go in FixedUpdate
        Vector3 move = transform.right * _moveInput.x + transform.forward * _moveInput.y;
        _rb.MovePosition(_rb.position + move * _moveSpeed * Time.fixedDeltaTime);
    }
}
```

## ScriptableObject Event Channel

```csharp
// Decoupled event system using ScriptableObject channels (Ryan Hipple pattern)
using System;
using UnityEngine;

[CreateAssetMenu(menuName = "Events/Game Event")]
public class GameEventSO : ScriptableObject
{
    private Action _listeners;

    public void Raise()
    {
        _listeners?.Invoke();
    }

    public void Subscribe(Action listener) => _listeners += listener;
    public void Unsubscribe(Action listener) => _listeners -= listener;
}

// Generic version for typed events
[CreateAssetMenu(menuName = "Events/Float Event")]
public class FloatEventSO : ScriptableObject
{
    private Action<float> _listeners;

    public void Raise(float value) => _listeners?.Invoke(value);
    public void Subscribe(Action<float> l) => _listeners += l;
    public void Unsubscribe(Action<float> l) => _listeners -= l;
}

// Usage: MonoBehaviour subscribes/unsubscribes via lifecycle
public class HealthDisplay : MonoBehaviour
{
    [SerializeField] private FloatEventSO _healthChangedEvent;

    private void OnEnable() => _healthChangedEvent.Subscribe(OnHealthChanged);
    private void OnDisable() => _healthChangedEvent.Unsubscribe(OnHealthChanged);

    private void OnHealthChanged(float newHealth)
    {
        // Update UI
    }
}
```

## ScriptableObject Item Database

```csharp
using UnityEngine;

[CreateAssetMenu(menuName = "Items/Item Definition")]
public class ItemDefinitionSO : ScriptableObject
{
    [field: SerializeField] public string ItemId { get; private set; }
    [field: SerializeField] public string DisplayName { get; private set; }
    [field: SerializeField] public Sprite Icon { get; private set; }
    [field: SerializeField] public ItemType Type { get; private set; }
    [field: SerializeField, Range(0, 999)] public int MaxStack { get; private set; } = 1;

    [TextArea(2, 4)]
    [SerializeField] private string _description;
    public string Description => _description;
}

public enum ItemType { Weapon, Armor, Consumable, Quest, Misc }

// Database asset holds all items - no scene dependency
[CreateAssetMenu(menuName = "Items/Item Database")]
public class ItemDatabaseSO : ScriptableObject
{
    [SerializeField] private ItemDefinitionSO[] _items;

    private System.Collections.Generic.Dictionary<string, ItemDefinitionSO> _lookup;

    private void OnEnable()
    {
        _lookup = new();
        foreach (var item in _items)
            if (item != null)
                _lookup[item.ItemId] = item;
    }

    public ItemDefinitionSO GetItem(string id) =>
        _lookup.TryGetValue(id, out var item) ? item : null;
}
```

## New Input System Integration

```csharp
using UnityEngine;
using UnityEngine.InputSystem;

public class InputHandler : MonoBehaviour
{
    // Cached hash values - avoids string lookup per call
    private static readonly int SpeedHash = Animator.StringToHash("Speed");
    private static readonly int JumpHash = Animator.StringToHash("Jump");

    [SerializeField] private Animator _animator;

    private PlayerInputActions _inputActions;
    private Vector2 _moveInput;

    private void Awake()
    {
        _inputActions = new PlayerInputActions();
    }

    private void OnEnable()
    {
        _inputActions.Player.Enable();
        _inputActions.Player.Jump.performed += OnJump;
    }

    private void OnDisable()
    {
        _inputActions.Player.Jump.performed -= OnJump;
        _inputActions.Player.Disable();
    }

    private void Update()
    {
        _moveInput = _inputActions.Player.Move.ReadValue<Vector2>();
        _animator.SetFloat(SpeedHash, _moveInput.magnitude);
    }

    private void OnJump(InputAction.CallbackContext ctx)
    {
        _animator.SetTrigger(JumpHash);
    }
}
```

## Object Pool (Generic)

```csharp
using System.Collections.Generic;
using UnityEngine;

public class ObjectPool<T> where T : Component
{
    private readonly T _prefab;
    private readonly Transform _parent;
    private readonly Queue<T> _pool = new();

    public ObjectPool(T prefab, Transform parent, int initialSize = 10)
    {
        _prefab = prefab;
        _parent = parent;
        for (int i = 0; i < initialSize; i++)
            _pool.Enqueue(CreateNew());
    }

    public T Get(Vector3 position, Quaternion rotation)
    {
        T instance = _pool.Count > 0 ? _pool.Dequeue() : CreateNew();
        instance.transform.SetPositionAndRotation(position, rotation);
        instance.gameObject.SetActive(true);
        return instance;
    }

    public void Return(T instance)
    {
        instance.gameObject.SetActive(false);
        _pool.Enqueue(instance);
    }

    private T CreateNew()
    {
        T obj = Object.Instantiate(_prefab, _parent);
        obj.gameObject.SetActive(false);
        return obj;
    }
}

// Usage:
// private ObjectPool<Bullet> _bulletPool;
// void Awake() => _bulletPool = new ObjectPool<Bullet>(_bulletPrefab, transform, 20);
// void Fire() => _bulletPool.Get(muzzle.position, muzzle.rotation);
// (Bullet calls _bulletPool.Return(this) on OnDisable)
```

## Anti-Patterns

- **`GetComponent` in `Update()`**: Allocates and searches every frame. Cache in `Awake()` with `_rb = GetComponent<Rigidbody>()`.
- **`FindObjectOfType` in `Update()` or `Start()`**: Scene-wide search on every call. Use dependency injection via `[SerializeField]` or a service locator.
- **Direct scene references between unrelated systems**: Creates coupling that breaks on scene change. Use ScriptableObject event channels or an EventBus singleton.
- **Physics in `Update()`**: Force application in `Update` is framerate-dependent. Physics always goes in `FixedUpdate`.
- **LINQ in hot path**: `enemies.Where(e => e.IsAlive).ToList()` allocates a new list every call. Use manual loops or pre-allocated `List<T>` with `Clear()` + add.
- **`public` fields for inspector exposure**: Exposes fields to all code. Use `[SerializeField] private` instead; same inspector visibility, better encapsulation.
