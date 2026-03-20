# Operation RSI — ZSA Voyager Layout Spec

## Rules

1. Every key earns its slot by weight (0-7). No free rides.
2. No timing-dependent dual-function. "Hold on other key press" only.
3. No Shift on L0. OSM + CapsWord + held Shift on L1 cover everything.
4. Backspace repeats when held. No dual-function on it.
5. Layer top rows are dead zones. F-keys under index/middle only.
6. Pre-cook fixed combos. Keep raw modifiers for flexible ones.
7. L1 left is mouse-safe territory. One-hand-plus-mouse keys live here.
8. Openers outrank closers. Closers drop a layer.
9. Group symbols by syntactic role, not math vs bitwise.
10. Low-weight L0 outer columns are parking spots for layer duplicates.

## Key reference

| Label    | Meaning                          | Oryx config                              |
|----------|----------------------------------|------------------------------------------|
| Spc/L1   | Space on tap, activate L1 on hold | Layer-tap: layer 1, keycode Space        |
| L2       | Activate L2 while held           | MO(2) or layer hold                      |
| held     | Layer hold key (transparent)     | The key holding the current layer active  |
| vCtrl    | Transparent -- Ctrl passes through | Same as L0 thumb (Ctrl)                 |
| vBksp    | Transparent -- Bksp passes through | Same as L0 thumb (Backspace)            |
| vL2      | Transparent -- L2 passes through | Same as L0 thumb (MO(2))                 |
| vSpc     | Transparent -- Spc/L1 passes through | Same as L0 thumb (layer-tap)          |
| AltT     | Pre-cooked Alt+Tab               | Single key macro: Alt+Tab                |
| CtrT     | Pre-cooked Ctrl+Tab              | Single key macro: Ctrl+Tab               |
| CsT      | Pre-cooked Ctrl+Shift+Tab        | Single key macro: Ctrl+Shift+Tab         |
| PrtS     | Print Screen                     | KC_PSCR                                  |
| OSM      | One-Shot Modifier: Shift         | OSM(MOD_LSFT)                            |
| Shft     | Shift (hold)                     | KC_LSFT                                  |
| Sup      | Super / GUI / Windows key        | KC_LGUI                                  |
| CWd      | Caps Word toggle                 | CW_TOGG                                  |
| Unsc     | Underscore                       | S(KC_MINS) or Shift+minus                |
| Ct`      | Pre-cooked Ctrl+`                | Single key macro: Ctrl+`                 |
| CsP      | Pre-cooked Ctrl+Shift+P          | Single key macro: Ctrl+Shift+P           |
| AF4      | Pre-cooked Alt+F4                | Single key macro: Alt+F4                 |
| Ent      | Enter / Return                   | KC_ENT                                   |
| Spc      | Plain Space (on L1, so you can space without releasing layer) | KC_SPC |
| Del      | Forward Delete                   | KC_DEL                                   |
| _        | Dead / empty key                 | KC_NO or transparent                     |

## Thumbs

```
L outer (rest):  Space / L1    R inner (reach): Backspace (plain)
L inner (reach): Ctrl          R outer (rest):  L2 hold
```

## Weight maps

### L0

```
Left:                              Right:
  1  2  3  3  3  2                   2  3  3  3  2  1
  2  4  6  6  6  3                   3  6  6  6  4  2
  2  5  6  7  7  4                   4  7  7  6  5  2
  2  3  4  5  5  3                   3  5  5  4  3  2
           Spc=7  Ctrl=5            Bksp=7  L2=5
```

### L1 (left outer held) / L2 mirrors this

```
Left (pinned):                     Right (free):
  0  0  0  0  0  0                   0  0  0  0  0  0
  1  2  4  6  6  3                   3  6  6  5  3  1
  1  3  5  7  7  3                   3  7  7  6  4  2
  1  3  4  5  3  3                   3  6  6  5  4  2
        held  3                      5  4
```

L2 = exact mirror (right outer held, left free).

---

## L0 layout

```
Left:                              Right:
  Tab  1    2    3    4    5         6    7    8    9    0    Ent
  Alt  Q    W    E    R    T         Y    U    I    O    P    \
  Esc  A    S    D    F    G         H    J    K    L    ;    '
  Sup  Z    X    C    V    B         N    M    ,    .    /    -
                 Spc/L1   Ctrl      Bksp      L2
```

Note: Ent at R1C12 (wt1) is parking for gaming/chat. Primary = on L1 home row.

## L1 layout (Space held)

```
Left (pinned):                     Right (free):
  _    _    _    F1   F3   F4        F6   F9   F10  _    _    _
  _    AltT PrtS Ent  Unsc CtrT     _    !    *    &    _    _
  _    Sup  Shft :    =    Spc      <-   down up   ->   _    _
  _    CsT  OSM  Tab  _    _        _    (    {    [    <    _
            held      vCtrl         vBksp     vL2
```

Key: AltT=Alt+Tab, PrtS=PrtSc, CtrT=Ctrl+Tab, CsT=Ctrl+Shift+Tab,
OSM=One-Shot Shift, Unsc=Underscore, Spc=Space (so you can space
without releasing L1)

Symbol groups on R side:
- R2: prefix/reference ops (! * &)
- R3: Vim arrows
- R4: openers (( { [ <) -- perfect 6,6,5,4 weight match

## L2 layout (R outer held)

```
Left (free):                       Right (pinned):
  _    _    _    Play Vol+ Mute     Prev Next Vol- _    _    _
  _    +    -    %    Del  CWd      Ct`  )    }    PgUp F2   _
  _    Home ~    |    ^    End      CsP  >    ]    PgDn F5   _
  _    `    #    @    $    \        AF4  F11  F12  F7   F8   _
            vSpc     vCtrl          vBksp    held
```

Key: CWd=CapsWord, Ct`=Ctrl+`, CsP=Ctrl+Shift+P, AF4=Alt+F4

Symbol groups on L side:
- R2: arithmetic (+ - %)
- R3: bitwise (~ | ^) flanked by Home/End
- R4: shell/meta (` # @ $ \)

Shortcut groups on R side:
- C1: Zed shortcuts (Ct` CsP AF4)
- C2-C3: closers () } ] >)

## Pre-cooked shortcuts (Oryx single keys)

| Key sends       | Weight | Mouse-safe |
|-----------------|--------|------------|
| Alt+Tab         | 5      | Yes        |
| Ctrl+Tab        | 5      | Yes        |
| Ctrl+Shift+Tab  | 4      | Yes        |
| PrtSc           | 5      | Yes        |
| Ctrl+`          | 3      | No         |
| Ctrl+Shift+P    | 3      | No         |
| Alt+F4          | 3      | No         |

## Oryx settings

- All dual-function: "When to send Hold" -> "When another key is pressed"
- Auto Shift: OFF
- Caps Word: ON
- Quick Tap Term: 0 ms
- Tapping Term: 200 ms

## Open issues

1. GNOME tiling -- need pre-cooked Super+Arrow (4 keys), maybe Super+PgUp/PgDn
   for workspace switching. Current Super+Arrow requires L1 pinky hold.
2. Insert key -- missing entirely. Needed for Shift+Insert paste in terminals.
3. Gaming layer -- deferred. Just L0 with Space as plain tap (no L1 dual-function).
   Harrison will handle War Thunder Shift via mouse button rebinding.
4. Ctrl+Shift+Arrow -- works via Space+Shift+Ctrl three-key hold (all different
   fingers). Verify comfort before flashing.

## Resolved issues

1. @ and $ -- bumped from wt2 to wt3+. Current L2 placement is fine.
2. F10 -- moved to L1 top row with other wt0 F-keys (cols 8-9, index+middle).
   F9 also moves to L1 top row. Both join F4/F6 cluster.
3. - on L0 and L1 -- intentional. L0 is low-weight parking (col 12).
   L1 is the actual primary in a usable position.
4. \ on L0 and L2 -- same pattern. L0 outer col is parking. L2 copy added.
5. Gaming layer -- partially deferred. L0 is sufficient for most games. Space
   dual-function needs a gaming layer override (plain Space). Shift handled
   via mouse button rebind.
6. F-key distribution -- symmetric 3+3 center cluster on L1 top row.
   F1 F3 F4 (left cols 4-6) / F6 F9 F10 (right cols 7-9).
7. Underscore -- added to L1 left R2C5 (wt6). Mouse-safe for snake_case.
8. Symbol grouping -- reorganized by C99/Go syntactic role. Prefix ops,
   openers, arithmetic, bitwise, shell/meta in distinct clusters.
9. L0 Enter -- swapped = at R1C12 (wt1 parking) for Enter. Enables
   gaming/MMO chat without layer switching. = lives on L1 home row (wt7).
