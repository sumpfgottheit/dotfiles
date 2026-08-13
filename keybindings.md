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

Fokus (Panes) und Tabwechsel teilen sich **nie** denselben Shortcut: Tabs
liegen auf `Alt`/`⌘` pur, Fokus eine Ebene tiefer auf `Alt+Shift`/`⌘⇧`.

| Aktion | macOS | Windows |
|---|---|---|
| **Tab** vorheriger (h/j) | `⌘H` / `⌘J` | `Alt+H` / `Alt+J` |
| **Tab** nächster (k/l) | `⌘K` / `⌘L` | `Alt+K` / `Alt+L` |
| Tab vorheriger (Pfeile) | `⌘←` / `⌘↓` | `Alt+←` / `Alt+↓` |
| Tab nächster (Pfeile) | `⌘↑` / `⌘→` | `Alt+↑` / `Alt+→` |

`Ctrl+←`/`Ctrl+→` als Tab-Alternative wurde entfernt: macOS reserviert diese
Kombination systemweit für den Spaces-Wechsel in Mission Control und lässt
sie nie bis zum Terminal durch.
| Tab vor / zurück (Alternative) | `⌃←` / `⌃→` | `Ctrl+←` / `Ctrl+→` |
| **Fokus** links / unten / oben / rechts | `⌘⇧H` `⌘⇧J` `⌘⇧K` `⌘⇧L` | `Alt+⇧H` `Alt+⇧J` `Alt+⇧K` `Alt+⇧L` |
| Fokus (Pfeile) | `⌘⇧←` `⌘⇧↓` `⌘⇧↑` `⌘⇧→` | `Alt+⇧←` `Alt+⇧↓` `Alt+⇧↑` `Alt+⇧→` |
| Neuer Tab | `⌘T` | `Alt+T` |
| Tab nach links / rechts verschieben | `⌘I` / `⌘O` | `Alt+I` / `Alt+O` |
| Floating Panes an/aus | `⌘F` | `Alt+F` |
| Pane größer / kleiner | `⌘+` / `⌘-` | `Alt++` / `Alt+-` |
| Layout weiter / zurück | `⌘D` / `⌘U` | `Alt+D` / `Alt+U` |
| Pane gruppieren / Markierung | `⌘P` / `⌘⇧P` | `Alt+P` / `Alt+⇧P` |
| Locked-Modus an/aus | `⌃G` | `Ctrl+G` |
| Zellij beenden | `⌃Q` | `Ctrl+Q` |

Tab-Zuordnung: linkes Paar `h`/`j` = vorheriger, rechtes Paar `k`/`l` =
nächster Tab. Jeder Pfeil spiegelt sein vim-Pendant (`h`~`←`, `j`~`↓`,
`k`~`↑`, `l`~`→`), damit Buchstabe und Pfeil immer dieselbe Aktion auslösen.

`⌘H` war früher „Ghostty ausblenden" (AppKit-Menüeintrag, von
`keybind = clear` nicht erreichbar) — deshalb bislang nur `⌥H`, ohne Cmd.
Sobald Hide in den macOS-Kurzbefehl-Einstellungen (Tastatur → Kurzbefehle →
App-Kurzbefehle) auf einen anderen Kurzbefehl verlegt ist, ist `⌘H` frei;
geprüft über:

```bash
defaults read com.mitchellh.ghostty NSUserKeyEquivalents
```

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
`horizontal` und `stacked` sind deshalb dort mit aufgeführt.

Drei Fallstricke beim Schreiben dieser Datei:

1. `default_tab_template` benutzen, **nicht** `tab_template name="…"`. Ein
   benanntes Template greift nur dort, wo es angefordert wird — zur Laufzeit
   per `NewTab` erzeugte Tabs bekämen sonst weder Tab- noch Statusleiste.
2. `default_tab_template` und `swap_tiled_layout` müssen **innerhalb** des
   `layout`-Knotens stehen. Auf oberster Ebene stehen sie nur in einer
   separaten `.swap.kdl` — so gibt `zellij setup --dump-swap-layout` sie aus,
   was leicht in die Irre führt.
3. In den Swap-Layouts `tab` als Knotennamen verwenden, damit
   `default_tab_template` auch dort greift.
4. `max_panes` zählt die Plugin-Panes des Templates mit — Tab-Leiste und
   Statusleiste sind je ein Pane. Es gilt also `max_panes = sichtbare Panes + 2`,
   im Grid daher 4/6/8 für 2/4/6 echte Panes. Mit 2/4/6 greift bei vier Panes
   fälschlich das 3×2-Raster und füllt nur 3 + 1 statt 2×2. Zellijs eingebautes
   `horizontal` zeigt dieselbe Differenz: zwei deklarierte Panes, `max_panes=4`.

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
