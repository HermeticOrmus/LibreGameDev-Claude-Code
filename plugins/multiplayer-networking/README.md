# multiplayer-networking

Multiplayer networking plugin for LibreGameDev. Covers Godot High-Level Multiplayer API, MultiplayerSynchronizer, client-side prediction, server reconciliation, rollback netcode concepts, lag compensation, and authoritative server architecture.

## Components

- **netcode-engineer**: Agent with expertise in Godot HLMP, rollback netcode, client prediction, interpolation, lag compensation, and architecture by genre
- **multiplayer**: Command for host/connect setup, state sync design, and debugging
- **netcode-patterns**: Skill library with MultiplayerSynchronizer setup, client-side prediction with reconciliation, entity interpolation, ENet host/client setup

## Architecture by Genre

| Genre | Architecture | Godot Tools |
|-------|-------------|-------------|
| Co-op action | Server-authoritative + client prediction | ENet + MultiplayerSynchronizer |
| Fighting game | Rollback netcode | Custom rollback + ENet |
| Strategy/RTS | Lockstep deterministic | ENet + input broadcast |
| Casual co-op | Peer-to-peer host | Godot HLMP ENet |
| MMO-lite | Authoritative server + interest zones | Dedicated server |

## Security First

Multiplayer games are hacked. Always:
- Server validates all inputs (never trust client position/damage)
- Rate-limit client RPCs (prevent flood attacks)
- Validate all numerical inputs (reject NaN, Inf, >max values)
- Authority checks before any game state mutation

## Quick Start

Host a co-op game:
```
/multiplayer host "Godot 4 co-op game for 2-4 players over LAN"
```

Add client prediction:
```
/multiplayer sync "player movement with client-side prediction"
```

Debug desync:
```
/multiplayer debug "game state differs between host and client after 1 minute"
```
