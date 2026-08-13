# Tastatur-Setup: Ghostty + Zellij (macOS) / Windows Terminal + Zellij (Windows)

Deutsches Layout, TKL. Ziel ist ein plattformübergreifend identischer Griff.

## Dateien in diesem Repo

| Datei | Ziel | Von `make install` verteilt |
|---|---|---|
| `ghostty-config` | `~/.config/ghostty/config` | ja |
| `zellij-config.kdl` | `~/.config/zellij/config.kdl` | ja |
| `zellij-layout-default.kdl` | `~/.config/zellij/layouts/default.kdl` | ja |
| `windows-terminal-settings.json` | `settings.json` des Windows Terminal | **nein**, dort von Hand kopieren |

Karabiner ist bewusst nicht im Repo — die Konfiguration hängt an
geräte­spezifischen Vendor/Product-IDs und ist nicht portabel.

## Modifier-Vertrag

| Modifier | Gehört | Regel |
|---|---|---|
| `Ctrl+<Buchstabe>` | Zellij | Moduswechsel |
| `Alt+<Buchstabe>` | Zellij | Direktaktionen |
| `Ctrl+Shift+<Taste>` | Terminal-Emulator | ausschließlich Copy/Paste + Font |
| `Cmd` / `Win` | — | Win ist OS-weit reserviert; Cmd nur für Copy/Paste auf dem Mac |
| `Ctrl+Alt` | — | **nie belegen**, das ist AltGr für `{ [ ] } @ \ ~ \| €` |

Der Kerngedanke: **die Taste links neben der Leertaste** ist auf dem Mac `⌘`,
unter Windows `Alt`. Gleicher Griff, gleiche Aktion. Auf dem Mac funktionieren
alle Direktaktionen wahlweise auch mit `⌥` (zweite Taste von links).

Auf dem Mac kommt `⌘` nur deshalb bei Zellij an, weil Zellij das
Kitty-Keyboard-Protokoll aushandelt (`ESC[>1u`) und Ghostty `⌘U` als
`ESC[117;9u` kodiert. Windows Terminal kann das nicht — dort greifen die
Alt-Varianten. In `config.kdl` sind beide Modifier auf dieselbe Aktion gebunden,
darum ist die Datei auf beiden Plattformen identisch.

## Direktaktionen — überall außer im Locked-Modus

| Aktion | macOS | Windows |
|---|---|---|
| Fokus links / unten / oben / rechts | `⌘←` `⌘↓` `⌘↑` `⌘→` | `Alt+←` `Alt+↓` `Alt+↑` `Alt+→` |
| Fokus unten / oben (vim) | `⌘J` / `⌘K` | `Alt+J` / `Alt+K` |
| Fokus **links**, sonst Tab links | `⌥H` ⚠️ | `Alt+H` |
| Fokus rechts, sonst Tab rechts | `⌘L` | `Alt+L` |
| Neuer Tab | `⌘T` | `Alt+T` |
| Tab nach links / rechts verschieben | `⌘I` / `⌘O` | `Alt+I` / `Alt+O` |
| Tab vor / zurück | `⌃←` / `⌃→` | `Ctrl+←` / `Ctrl+→` |
| Floating Panes an/aus | `⌘F` | `Alt+F` |
| Pane größer / kleiner | `⌘+` / `⌘-` | `Alt++` / `Alt+-` |
| Layout weiter / zurück | `⌘D` / `⌘U` | `Alt+D` / `Alt+U` |
| Pane gruppieren / Markierung | `⌘P` / `⌘⇧P` | `Alt+P` / `Alt+⇧P` |
| Locked-Modus an/aus | `⌃G` | `Ctrl+G` |
| Zellij beenden | `⌃Q` | `Ctrl+Q` |

⚠️ **Die einzige Ausnahme:** `⌘H` ist auf dem Mac „Ghostty ausblenden" — ein
AppKit-Menüeintrag, den `keybind = clear` nicht freiräumt. Dafür `⌥H` benutzen.

## Modi — auf beiden Plattformen identisch

| Modus | Taste | Zurück |
|---|---|---|
| Pane | `Ctrl+P` | `Esc` / `Enter` |
| Tab | `Ctrl+T` | `Esc` / `Enter` |
| Resize | `Ctrl+N` | `Esc` / `Enter` |
| Move | `Ctrl+H` | `Esc` / `Enter` |
| Scroll / Suche | `Ctrl+S` | `Esc` / `Enter` |
| Session | `Ctrl+O` | `Esc` / `Enter` |
| Tmux-Kompatibilität | `Ctrl+B` | `Esc` / `Enter` |

### Pane-Modus — `Ctrl+P`, dann

`n` neu · `d` nach unten teilen · `r` nach rechts teilen · `s` gestapelt ·
`x` schließen · `f` Vollbild · `w` floating · `e` floating ⇄ eingebettet ·
`i` anheften · `z` Rahmen · `c` umbenennen · `h j k l` bzw. Pfeile Fokus

### Tab-Modus — `Ctrl+T`, dann

`n` neu · `x` schließen · `r` umbenennen · `1`–`9` direkt · `h` / `l` vor/zurück ·
`Tab` letzter Tab · `s` Sync · `b` Pane herauslösen · `[` / `]` nach links/rechts
herauslösen

### Resize `Ctrl+N` · Move `Ctrl+H`

`h j k l` bzw. Pfeile · `H J K L` verkleinern · `+` / `-`

### Scroll — `Ctrl+S`, dann

`j` / `k` zeilenweise · `d` / `u` halbe Seite · `Ctrl+F` / `Ctrl+B` seitenweise ·
`s` suchen, dann `n` / `p` weiter/zurück · `e` Scrollback im Editor öffnen

### Session — `Ctrl+O`, dann

`w` Session-Manager · `l` Layout-Manager · `p` Plugins · `c` Konfiguration ·
`d` detach

## Layouts

Zyklus mit `⌘D` / `Alt+D`, rückwärts `⌘U` / `Alt+U`:

    grid → vertical → horizontal → stacked → (Basis)

`grid` schaltet nach Anzahl der Panes um:

| Panes | Anordnung |
|---|---|
| bis 2 | nebeneinander |
| bis 4 | 2 × 2 |
| bis 6 | 3 × 2 |

Definiert in `~/.config/zellij/layouts/default.kdl`. Sobald diese Datei
existiert, ersetzt sie die eingebauten Swap-Layouts vollständig — `vertical`,
`horizontal` und `stacked` sind deshalb dort mit aufgeführt. `tab_template` und
`swap_tiled_layout` müssen in einer Layout-Datei **innerhalb** des
`layout`-Knotens stehen; auf oberster Ebene stehen sie nur in einer separaten
`.swap.kdl`.

## Terminal-Emulator

| Aktion | macOS (Ghostty) | Windows (Windows Terminal) |
|---|---|---|
| Kopieren | `⌘C` oder `⌃⇧C` | `Ctrl+Shift+C`, Mausauswahl kopiert automatisch |
| Einfügen | `⌘V` oder `⌃⇧V` | `Ctrl+Shift+V` |
| Schrift größer / kleiner | `⌃⇧↑` / `⌃⇧↓` | `Ctrl+Shift+↑` / `Ctrl+Shift+↓` |
| Schrift zurücksetzen | `⌃⇧0` | `Ctrl+Shift+0` |
| Einstellungen | Menü | `Ctrl+,` |

`Ctrl+C` ist auf beiden Plattformen wieder SIGINT.

## Hardware

**Keychron K1 Pro (macOS)** — in Karabiner ist nur `right_command ⟷
right_option` getauscht. Damit liegt AltGr auf der Taste rechts neben der
Leertaste, genau wie unter Windows: `\` ist auf beiden Systemen
„Taste rechts von Space + ß". Die linke Seite bleibt unangetastet, damit `⌘`
neben der Leertaste bleibt.

`macos-option-as-alt = left` — die linke Option-Taste wird zu Alt, die rechte
bleibt Compose. Sonst gingen `\ [ ] { } @` verloren.

## Windows Terminal

58 kollidierende Default-Keybindings sind per `{"id": null}` gelöst, 3 neu
gebunden (Font-Resize), 8 Defaults bleiben unberührt: `alt+f4`, `f11`,
`ctrl+,`, `ctrl+shift+c`, `ctrl+shift+v`, `ctrl+insert`, `shift+insert`, `menu`.

Kritisch waren `ctrl+alt+1` … `ctrl+alt+9` (Tab-Wechsel) — das ist AltGr+1…9
und hat auf deutschem Layout `{ [ ] }` blockiert.

Sobald in der WT-Oberfläche eine Einstellung geändert wird, schreibt Windows
Terminal die `settings.json` neu und verwirft dabei die Kommentare. Die
Bindings selbst überstehen das.
