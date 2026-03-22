```
ZSA VOYAGER LAYOUT -- "RSI Reducer"
====================================
Source: https://configure.zsa.io/voyager/layouts/rGPg7

Three layers on a 6x4 + 2-thumb split. Layer 0 is standard QWERTY so
gaming and muscle memory work unmodified. Layers 1 and 2 are momentary
(held via right thumb keys) and put symbols, navigation, and media
within reach of the home position.

Design goals:
  - No reaching for shifted-number symbols; they live on Layer 1
  - Brackets mirrored on the home row (L1 Row 3) for programming
  - Home row mods on L2 left hand enable modifier+arrow combos
    without leaving home position
  - Navigation cluster (arrows, Home/End, PgUp/PgDn) on L2 right hand
  - Media and RGB controls accessible but out of the way (L2 top rows)


SETTINGS
--------
QMK 25.0 defaults throughout; nothing overridden.

  Tapping term:          200ms (default)
  Permissive hold:       off
  Hold on other key:     off
  Quick tap term:        default
  Mouse keys:            disabled
  RGB startup speed:     60


LAYER 0 -- BASE
================
Standard QWERTY. Modifiers on the outer columns and thumbs.

LEFT HAND                          RIGHT HAND
+----- -----+----- -----+----- -----+  +----- -----+----- -----+----- -----+
|Caps |  1  |  2  |  3  |  4  |  5  |  |  6  |  7  |  8  |  9  |  0  | Bksp|
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
| Tab |  Q  |  W  |  E  |  R  |  T  |  |  Y  |  U  |  I  |  O  |  P  | Alt |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|Shift|  A  |  S  |  D  |  F  |  G  |  |  H  |  J  |  K  |  L  |  ;  |Shift|
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|Super|  Z  |  X  |  C  |  V  |  B  |  |  N  |  M  |  ,  |  .  |  /  |Enter|
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
                        +-------+----+  +-------+----+
                        | Space |Ctrl|  |  L2   | L1 |
                        +-------+----+  +-------+----+


LAYER 1 -- SYMBOLS / F-KEYS (hold R-T4)
========================================
Shifted-number symbols on Row 2 in their number positions (skip parens;
they are on the home row). Brackets paired across hands on Row 3.
Row 4 holds remaining symbols and utility keys.

LEFT HAND                          RIGHT HAND
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     | F1  | F2  | F3  | F4  | F5  |  | F6  | F7  | F8  | F9  | F10 |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |  !  |  @  |  #  |  $  |  %  |  |  ^  |  &  |  *  |  -  |  \  |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |  ?  |  [  |  {  |  (  |  <  |  |  >  |  )  |  }  |  ]  |  :  |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |  =  |  '  |  `  |Caps |     |  |     |Bksp |Enter| Tab |SysRq|     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
                        +-------+----+  +-------+----+
                        | Space |Ctrl|  |  L2   |HELD|
                        +-------+----+  +-------+----+


LAYER 2 -- NAV / MEDIA / RGB (hold R-T3)
=========================================
Left home row becomes modifiers (Super, Alt, Ctrl, Shift) so you can
chord with right-hand arrows. Navigation on the right, media on the
left, RGB and reset on Row 1.

LEFT HAND                          RIGHT HAND
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
| Esc |Spd- |Spd+ |Brt- |Brt+ |Hue- |  |Hue+ |RMod |RTog |Sat+ |Sat- |Reset|
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |Mute |Vol- |Vol+ |Prev |Home |  | End |Next |Play |  _  |  |  |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |Super| Alt |Ctrl |Shift|Bksp |  | Left| Down|  Up |Right|     |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
|     |  +  |  "  |  ~  | F11 | F12 |  | Tab |PgDn |PgUp |     |     |     |
+-----+-----+-----+-----+-----+-----+  +-----+-----+-----+-----+-----+-----+
                        +-------+----+  +-------+----+
                        | Space |Ctrl|  | HELD  | L1 |
                        +-------+----+  +-------+----+
```
