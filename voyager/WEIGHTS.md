# Function Weight List -- Individual Keys, 0-7 Scale

## Already placed

| Function     | Wt | Layer | Position          | Mouse-safe? |
|-------------|-----|-------|-------------------|-------------|
| Space/L1    | 7   | L0    | L thumb outer     | Yes         |
| Backspace   | 7   | L0    | R thumb inner     | Yes         |
| Ctrl        | 5   | L0    | L thumb inner     | Yes         |
| L2 hold     | 5   | L0    | R thumb outer     | No          |
| A-Z letters | 7-4 | L0    | Rows 2-4          | Yes         |
| 0-9 numbers | 2-3 | L0    | Row 1             | N/A         |
| Enter       | 7   | L0+L1 | L0 R1C12 (park), L1 R2C4 | Yes (L1) |
| Esc         | 2   | L0    | R3 C1             | N/A         |
| , . ; ' / - | 2-4 | L0    | QWERTY positions  | N/A         |
| \           | 4   | L0+L2 | L0 R2C12 (park), L2 R4C6 | No |

## Navigation

| Function | Wt | Layer | Position       | Mouse-safe? | Notes                      |
|---------|-----|-------|----------------|-------------|----------------------------|
| ->      | 7   | L1    | R3 C4 (Vim L)  | No          | R home row                 |
| <-      | 7   | L1    | R3 C1 (Vim H)  | No          | R home row                 |
| up      | 7   | L1    | R3 C3 (Vim K)  | No          | R home row                 |
| down    | 7   | L1    | R3 C2 (Vim J)  | No          | R home row                 |
| Enter   | 7   | L1    | L R2C4          | Yes         | Mouse-safe, pinned side    |
| Tab     | 5   | L1    | L R4C4          | Yes         | Mouse-safe, pinned side    |
| Super   | 4   | L1    | L R3C2          | Yes         | Mouse-safe, pinned side    |
| Home    | 3   | L2    | L R3C2          | No          | Flanks bitwise group       |
| End     | 3   | L2    | L R3C6          | No          | Flanks bitwise group       |
| Del     | 3   | L2    | L R2C5          | No          |                            |
| PgUp    | 2   | L2    | R R2C4          | No          |                            |
| PgDn    | 2   | L2    | R R3C4          | No          |                            |

## Symbols -- Go core ops

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| :       | 7   | L1    | L R3C4   | := is the #1 Go operator. Mouse-safe |
| =       | 7   | L1    | L R3C5   | Every assignment, comparison. Mouse-safe |
| _       | 6   | L1    | L R2C5   | snake_case constant use. Mouse-safe  |

## Symbols -- prefix/reference ops

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| !       | 5   | L1    | R R2C2   | Negation, != operator               |
| *       | 5   | L1    | R R2C3   | Pointers, multiplication            |
| &       | 5   | L1    | R R2C4   | Address-of, && operator             |

## Symbols -- openers

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| (       | 6   | L1    | R R4C2   | Every function call. wt6 slot       |
| {       | 6   | L1    | R R4C3   | Every block, struct. wt6 slot       |
| [       | 5   | L1    | R R4C4   | Arrays, slices. wt5 slot            |
| <       | 4   | L1    | R R4C5   | Generics, comparisons. wt4 slot     |

## Symbols -- closers

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| )       | 4   | L2    | R R2C2   | Auto-closed often                   |
| }       | 4   | L2    | R R2C3   | Auto-closed often                   |
| ]       | 4   | L2    | R R3C3   | Auto-closed often                   |
| >       | 4   | L2    | R R3C2   | Auto-closed sometimes               |

## Symbols -- arithmetic

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| +       | 4   | L2    | L R2C2   | +=, arithmetic                      |
| -       | 4   | L0+L2 | L0 R4C12 (park), L2 R2C3 | Subtraction, flags |
| %       | 4   | L2    | L R2C4   | Modulo, Printf format               |

## Symbols -- bitwise

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| ~       | 4   | L2    | L R3C3   | Bitwise NOT (C99), home dir         |
| |       | 4   | L2    | L R3C4   | Pipe, || operator                   |
| ^       | 4   | L2    | L R3C5   | Bitwise XOR                         |

## Symbols -- shell/meta

| Function | Wt | Layer | Position | Notes                              |
|---------|-----|-------|----------|--------------------------------------|
| `       | 4   | L2    | L R4C2   | Go raw strings, markdown code       |
| #       | 4   | L2    | L R4C3   | C99 preprocessor                    |
| @       | 4   | L2    | L R4C4   | Email, annotations                  |
| $       | 4   | L2    | L R4C5   | Shell vars                          |
| \       | 4   | L2    | L R4C6   | Escape char. Also parked on L0      |

## Modifiers + shift

| Function      | Wt | Layer | Position  | Mouse-safe? | Notes                    |
|--------------|-----|-------|-----------|-------------|--------------------------|
| OSM Shift    | 6   | L1    | L R4C3    | Yes         | Capital letters, one-shot |
| Shift (hold) | 6   | L1    | L R3C3    | Yes         | Shift+Arrow select       |
| CapsWord     | 3   | L2    | L R2C6    | No          | Extended caps, constants  |
| Alt (raw)    | 2   | L0    | R2C1      | No          | Alt+Tab precooked        |

## Pre-cooked shortcuts

| Function        | Wt | Layer | Position  | Mouse-safe? | Notes                  |
|----------------|-----|-------|-----------|-------------|------------------------|
| Alt+Tab        | 5   | L1    | L R2C2    | Yes         | Window switch           |
| Ctrl+Tab       | 5   | L1    | L R2C6    | Yes         | Tab switch              |
| Ctrl+Shift+Tab | 4   | L1    | L R4C2    | Yes         | Prev tab                |
| PrtSc          | 5   | L1    | L R2C3    | Yes         | Screenshots constantly  |
| Ctrl+`         | 3   | L2    | R R2C1    | No          | Zed terminal            |
| Ctrl+Shift+P   | 3   | L2    | R R3C1    | No          | Zed palette             |
| Alt+F4         | 3   | L2    | R R4C1    | No          | Close window            |

## F-keys

| Function       | Wt | Layer | Position           | Notes                        |
|---------------|-----|-------|--------------------|------------------------------|
| F1,F3,F4      | 0   | L1    | Top row L C4-C6    | Symmetric 3+3 center cluster |
| F6,F9,F10     | 0   | L1    | Top row R C1-C3    | Symmetric 3+3 center cluster |
| F2,F5         | 2   | L2    | R R2C5, R R3C5     | Rename, refresh              |
| F7,F8         | 1   | L2    | R R4C4-C5          | Debugger stepping            |
| F11,F12       | 2   | L2    | R R4C2-C3          | Fullscreen, devtools         |

## System + media

| Function    | Wt | Layer | Position        | Notes          |
|------------|-----|-------|-----------------|----------------|
| Vol Up     | 1   | L2    | L Top C5        | Few times/day  |
| Vol Down   | 1   | L2    | R Top C3        | Few times/day  |
| Mute       | 1   | L2    | L Top C6        | Few times/day  |
| Play/Pause | 1   | L2    | L Top C4        | Few times/day  |
| Prev       | 1   | L2    | R Top C1        | Few times/day  |
| Next       | 1   | L2    | R Top C2        | Few times/day  |

## Missing / unplaced

| Function | Wt | Notes                                          |
|---------|-----|-------------------------------------------------|
| Insert  | 1   | Needed for Shift+Insert paste. Find a L2 slot. |
