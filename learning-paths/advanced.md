# Advanced — multiplayer, telemetry, launch, post-launch ops

You're shipping. Now the work is multiplayer netcode that survives real networks, telemetry that lets you debug field issues, A/B testing for game balance, monetization ethics, platform-specific certs, and the post-launch ops that turn launches into businesses.

## What you'll learn

- Multiplayer netcode patterns that survive real networks
- Telemetry + crash reporting from production games
- A/B testing in games (game balance is statistical, not narrative)
- Monetization patterns that respect players
- Platform certification realities (Steam, console, mobile stores)
- Post-launch ops — patches, hotfixes, live events

## Path

### Phase 1 — Multiplayer netcode (8-15 hours)

**Read:**
- [`docs/06-networking-multiplayer/`](../docs/06-networking-multiplayer/) — full section, especially rollback / lockstep / prediction patterns

**Pick your model:**

```
/multiplayer I'm building a 4-player co-op action game. Players are usually on residential broadband. Some are on mobile data. What netcode model should I use?
```

Expected answer: host-authoritative P2P with client prediction. Reasoning: 4 players, co-op (no anti-cheat needs), broadband mostly, occasional mobile data.

```
/multiplayer I'm building a competitive 1v1 fighting game. Frame-perfect input is essential.
```

Expected: rollback netcode (GGPO-style).

**Implement:**

The plugin agents won't write you a netcode library from scratch (that's a multi-month project). They'll give you:
- The architectural design
- Library recommendations (NGO, Mirror, GGPO Unity port)
- Implementation outlines + key patterns
- Lag compensation strategy for hitscan

You then implement against a real library.

### Phase 2 — Telemetry + crash reporting (4-6 hours)

**Read:**
- [`docs/11-testing-qa/`](../docs/11-testing-qa/) — full section
- [`docs/12-deployment-distribution/`](../docs/12-deployment-distribution/) — deployment + monitoring chapters

**Implement:**

```
/playtest Design telemetry for my 4-player co-op game. I want to capture: session events (start, end, level completion), player actions (deaths, kills, ability uses), session metadata (platform, FPS averages, crashes). Privacy-respecting — no PII.
```

The agent should give:
- Event schema (JSON, with version field)
- Batch sending pattern (don't send every event; batch + send periodically)
- Privacy considerations (anonymized session ID, no PII)
- Storage approach (3rd party — Mixpanel, GameAnalytics, PostHog — or self-hosted via your backend)

Crash reporting:

```
/playtest Add crash reporting. I want stack trace, system info, last 100 telemetry events as breadcrumbs, automatic upload on next launch.
```

Engine-specific patterns:
- Unity: Cloud Diagnostics or Sentry SDK
- Godot: custom via GDScript exception hooks + breadcrumb log
- Unreal: built-in crash reporter + custom plugin

### Phase 3 — A/B testing + balance (3-4 hours)

**Read:**
- [`docs/13-case-studies/`](../docs/13-case-studies/) — if shipped with case studies, read all; otherwise reference how popular games use A/B testing

**Talk to the playtest agent:**

```
/playtest I want to A/B test the difficulty of my game's first boss. Currently 65% of players quit at this boss. I want to test: difficulty -10% (lower hp + lower damage), -20%, and -30%. How do I structure the test?
```

The agent should walk:
- Cohort assignment (deterministic, based on player ID hash)
- Sample size needed (typically 1000+ per cohort for statistical significance)
- Metrics to track (boss completion rate, retention day-2, average attempts before completion)
- Test duration (long enough for cohort to accumulate + boss to be reached)
- Decision criteria before starting

### Phase 4 — Monetization ethics (2-4 hours)

**Read:**
- [`docs/12-deployment-distribution/`](../docs/12-deployment-distribution/) — distribution + monetization chapter
- The `monetization-ethics` plugin's full SKILL.md content

**Decide:**

```
/monetize I'm shipping a mobile game. I don't want to use predatory patterns (gacha pull rates that hide odds, dark UX, fake scarcity). What ethical monetization options exist for my game type?
```

The agent should give:
- One-time purchase (premium games)
- Cosmetics only (Path of Exile, Fortnite model)
- Battle Pass (transparent value-per-tier)
- Sub-based (Apple Arcade-style or self-managed)
- Ad-supported (with rewarded ads, not interstitials breaking flow)

It should NOT recommend:
- Gacha with hidden rates
- Energy systems that gate play
- Dark UX patterns
- Pay-to-win in competitive games

### Phase 5 — Platform certs (varies by platform)

Each platform has its own cert process. The agent gives you generic patterns; the platform-specific details are NDA'd.

**Steam:**
- No formal cert; you publish via Steamworks
- Steam Cloud, Achievements, Workshop integration are optional but expected
- VAC anti-cheat if competitive
- Region availability + currency considerations

**Consoles (Switch, PlayStation, Xbox):**
- Each requires platform-holder NDA + dev kit
- Formal cert process: typically 2-6 weeks
- Common cert blockers: framerate not stable enough, save format wrong, lifecycle handling (suspend/resume) wrong, IP holder approval (for any non-original IP), online subsystem integration
- Plan for 2-3 cert attempts; don't promise launch date until you've passed cert once

**Mobile (iOS, Android):**
- App Store review: 24-72 hours typically
- Common rejections: in-app purchases without IAP framework, age rating wrong, privacy policy missing, ATT (App Tracking Transparency) prompt missing on iOS
- Play Store: similar but more permissive; cert delay if you trigger automated content review

### Phase 6 — Post-launch ops (ongoing)

**Read:**
- [`docs/12-deployment-distribution/`](../docs/12-deployment-distribution/) — post-launch chapter
- [`docs/13-case-studies/`](../docs/13-case-studies/) — case studies of shipped games

**Set up:**

- **Patch pipeline**: how does a fix go from your machine to production? Tested? Roll-back-able? Scheduled?
- **Hot fix vs. patch**: hot fixes are server-side configs + content; patches are binary updates that require platform re-cert
- **Live events**: scheduled in-game events keep players engaged; plan ~1 per month for a live game
- **Community management**: someone has to read forums + Discord + Steam reviews + reply
- **Telemetry dashboards**: not raw data — useful visualizations of retention, monetization, engagement, crashes
- **Capacity planning**: server load varies wildly; can your infrastructure handle 10× peak?

## What you've learned

By the end:

- You can ship multiplayer that survives real network conditions
- You can debug field issues via telemetry + crash reports
- You make balance decisions based on data, not vibes
- You monetize ethically without predatory patterns
- You can pass platform certs without 6 retries
- You can run a game as a service if you choose to

## What's still hard

Even with everything in this path, you'll hit:

- **Live-ops burnout** — sustaining a live game requires near-constant content updates. Teams burn out. Plan rotation.
- **Cert surprises** — platform holders change cert requirements; what passed last release might fail this one
- **Anti-cheat arms race** — cheaters adapt; you're never "done"
- **Platform policy changes** — Apple ATT, Google Play policies, Steam policies all change. Be ready to refactor.

## Where to go from here

- **Contribute back**: shipped a game using these patterns? Case study welcome via PR. See [CONTRIBUTING.md](../CONTRIBUTING.md).
- **Deepen your engine plugin**: the engine plugin you used most is the one you can deepen most usefully for future users.
- **Pair with other Libre-X-Claude-Code repos**:
  - [LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) — when your game has a companion mobile app or web companion
  - [LibreGEO-Claude-Code](https://github.com/HermeticOrmus/LibreGEO-Claude-Code) — when your game's marketing site needs to rank in AI search
  - [LibreDevOps-Claude-Code](https://github.com/HermeticOrmus/LibreDevOps-Claude-Code) — when you need dedicated server infrastructure for multiplayer
