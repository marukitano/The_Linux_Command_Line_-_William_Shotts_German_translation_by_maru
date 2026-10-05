# 10 – Prozesse

Moderne Betriebssysteme sind in der Regel **multitaskingfähig**.

Das bedeutet, dass sie viele Programme scheinbar gleichzeitig ausführen können.

Tatsächlich besitzt ein Prozessor jedoch nur eine begrenzte Anzahl von Rechenkernen. Das Betriebssystem erzeugt den Eindruck gleichzeitiger Ausführung, indem es die Rechenzeit in winzige Abschnitte aufteilt und sehr schnell zwischen den laufenden Programmen wechselt.

Unter Linux übernimmt der **Kernel** diese Aufgabe mithilfe von **Prozessen**.

Ein Prozess ist die laufende Instanz eines Programms. Der Kernel verwaltet alle Prozesse und entscheidet fortlaufend, welcher davon als Nächstes Rechenzeit erhält.

Im Alltag funktioniert das meist unbemerkt.

Gelegentlich kommt es jedoch vor, dass ein Programm nicht mehr reagiert oder der gesamte Rechner ungewöhnlich langsam wird.

In solchen Situationen ist es hilfreich zu wissen,

- welche Programme gerade laufen,
- wie viele Ressourcen sie verbrauchen,
- und wie sich problematische Prozesse beenden oder beeinflussen lassen.

In diesem Kapitel lernen wir die wichtigsten Werkzeuge der Kommandozeile kennen, mit denen sich Prozesse beobachten, steuern und bei Bedarf beenden lassen.

Folgende Befehle werden behandelt:

| Befehl | Beschreibung |
|--------|--------------|
| `ps` | Zeigt eine Momentaufnahme der aktuell laufenden Prozesse an. |
| `top` | Zeigt laufende Prozesse und deren Ressourcennutzung in Echtzeit an. |
| `jobs` | Listet die aktiven Jobs der aktuellen Shell auf. |
| `bg` | Setzt einen angehaltenen Job im Hintergrund fort. |
| `fg` | Holt einen Hintergrund-Job wieder in den Vordergrund. |
| `kill` | Sendet ein Signal an einen Prozess, z. B. zum Beenden. |
| `killall` | Sendet ein Signal an alle Prozesse mit einem bestimmten Namen. |
| `nice` | Startet ein Programm mit einer geänderten Priorität. |
| `renice` | Ändert die Priorität eines bereits laufenden Prozesses. |
| `nohup` | Führt einen Befehl so aus, dass er auch nach dem Abmelden weiterläuft. |
| `halt`, `poweroff`, `reboot` | Fahren das System herunter, schalten es aus oder starten es neu. |
| `shutdown` | Fährt das System kontrolliert herunter oder startet es neu. |

:::
## Prozess oder Programm?

Die Begriffe **Programm** und **Prozess** werden häufig verwechselt.

Ein **Programm** ist die ausführbare Datei auf der Festplatte, beispielsweise `firefox` oder `bash`.

Ein **Prozess** entsteht erst, wenn dieses Programm gestartet wird.

Dasselbe Programm kann sogar mehrfach gleichzeitig laufen – jede Instanz besitzt dann ihren eigenen Prozess mit einer eigenen Prozess-ID (PID).
:::

## Wie Prozesse funktionieren

Beim Start eines Linux-Systems beginnt der Kernel zunächst mit einigen eigenen Aufgaben und startet anschließend den ersten Prozess im Benutzerbereich.

Dieser Prozess trägt traditionell den Namen **`init`**.

Auf modernen Linux-Systemen übernimmt heute meist **`systemd`** diese Rolle.

`systemd` startet anschließend die verschiedenen Systemdienste, die das Betriebssystem im Hintergrund benötigt.

Ältere Linux-Distributionen verwendeten dafür ebenfalls `init`. Dieses führte eine Reihe von Shell-Skripten aus, die sich meist im Verzeichnis

```text
/etc
```

befanden und als **Init-Skripte** bezeichnet wurden.

Viele Systemdienste werden als sogenannte **Daemons** ausgeführt.

Ein Daemon ist ein Programm, das dauerhaft im Hintergrund läuft und normalerweise keine grafische Benutzeroberfläche besitzt.

Solche Programme erledigen Aufgaben wie beispielsweise

- Netzwerkdienste bereitstellen,
- Druckaufträge verwalten,
- Systemprotokolle schreiben,
- oder auf eingehende Verbindungen warten.

Deshalb arbeitet ein Linux-System auch dann weiter, wenn gerade niemand angemeldet ist.

:::
## Was ist ein Daemon?

Das Wort **Daemon** stammt aus der Unix-Welt und bezeichnet ein dauerhaft im Hintergrund laufendes Programm.

Unter Windows spricht man meist von einem **Dienst** (_Service_).

Beide erfüllen im Wesentlichen denselben Zweck.
:::

---

## Eltern- und Kindprozesse

Unter Linux können Programme weitere Programme starten.

Dadurch entsteht eine Hierarchie von Prozessen.

Der bereits laufende Prozess wird dabei als **Elternprozess** (_Parent Process_) bezeichnet.

Das neu gestartete Programm ist sein **Kindprozess** (_Child Process_).

Beispielsweise startet eine Shell jedes Programm, das du eingibst, als neuen Kindprozess.

Diese Beziehungen helfen dem Kernel dabei, Prozesse zu verwalten und nach ihrem Ende wieder aufzuräumen.

---

## Prozessinformationen

Damit der Kernel alle Prozesse verwalten kann, speichert er zu jedem Prozess verschiedene Informationen.

Dazu gehören unter anderem:

- eine eindeutige **Prozess-ID (PID)**,
- der Besitzer des Prozesses,
- die Benutzer- und Gruppenkennungen,
- der belegte Arbeitsspeicher,
- sowie der aktuelle Zustand des Prozesses.

Jeder neu gestartete Prozess erhält eine eindeutige **Process ID (PID)**.

Diese Nummern werden normalerweise aufsteigend vergeben.

Traditionell besitzt `init` beziehungsweise `systemd` immer die PID

```text
1
```

:::
## Warum beginnt alles mit PID 1?

Der Kernel selbst läuft nicht als gewöhnlicher Prozess.

Der erste normale Prozess, den der Kernel nach dem Start erzeugt, erhält deshalb die Prozess-ID **1**.

Von diesem Prozess werden anschließend nahezu alle weiteren Prozesse des Systems gestartet – direkt oder indirekt.
:::

---

# Prozesse anzeigen

Das wichtigste Werkzeug zum Anzeigen laufender Prozesse ist der Befehl ps (_ProcessStatus_)

```bash
ps
```

Er besitzt sehr viele Optionen.

In seiner einfachsten Form genügt jedoch:

```bash
[me@linuxbox ~]$ ps
PID TTY          TIME CMD
5198 pts/1 00:00:00 bash
10129 pts/1 00:00:00 ps
```

Hier sehen wir zwei Prozesse:

- `bash`
- `ps`

Standardmäßig zeigt `ps` jedoch nur Prozesse an, die zur aktuellen Terminal-Sitzung gehören.

Das reicht für viele Aufgaben nicht aus.

Schauen wir uns zunächst die einzelnen Spalten an.

| Spalte | Bedeutung |
|--------|-----------|
| `PID` | Eindeutige Prozess-ID. |
| `TTY` | Das Terminal, zu dem der Prozess gehört. |
| `TIME` | Bisher verbrauchte CPU-Zeit. |
| `CMD` | Name beziehungsweise Befehl des Prozesses. |

---

## Was bedeutet `TTY`?

Die Abkürzung

```text
TTY
```

steht ursprünglich für **Teletype**.

Historisch wurden Unix-Systeme über Fernschreiber bedient.

Obwohl diese Geräte längst verschwunden sind, hat sich die Bezeichnung bis heute erhalten.

Heute steht `TTY` einfach für das Terminal beziehungsweise die Konsole, von der aus ein Prozess gestartet wurde.

---

## Mehr Prozesse anzeigen

Mit der Option

```bash
x
```

werden alle Prozesse des aktuellen Benutzers angezeigt – unabhängig davon, ob sie einem Terminal zugeordnet sind.

```bash
ps x
```

Die Ausgabe sieht beispielsweise so aus:

```text
PID TTY STAT TIME COMMAND
2799 ?   Ssl  0:00 /usr/libexec/...
2820 ?   Sl   0:01 /usr/libexec/...
...
```

Fällt in der Spalte `TTY` ein

```text
?
```

auf, bedeutet das:

Der Prozess besitzt **kein zugeordnetes Terminal**.

Das ist typisch für Hintergrundprozesse oder Daemons.

Da die Liste schnell sehr lang werden kann, ist folgende Kombination oft praktischer:

```bash
ps x | less
```

Auch ein möglichst breites Terminalfenster hilft dabei, lange Befehlszeilen vollständig zu sehen.

---

## Die Prozesszustände (`STAT`)

Mit `ps x` erscheint zusätzlich die Spalte

```text
STAT
```

Sie zeigt den aktuellen Zustand eines Prozesses an.

Die wichtigsten Zustände sind:

| Zustand | Bedeutung |
|:-------:|-----------|
| `R` | Running – Prozess läuft oder wartet auf CPU-Zeit. |
| `S` | Sleeping – Prozess schläft und wartet auf ein Ereignis, z. B. eine Tastatureingabe oder Netzwerkdaten. |
| `D` | Uninterruptible Sleep – Prozess wartet auf Ein-/Ausgabe, beispielsweise auf eine Festplatte. |
| `T` | Stopped – Prozess wurde angehalten. |
| `Z` | Zombie – Der Prozess ist bereits beendet, wurde aber vom Elternprozess noch nicht vollständig aufgeräumt. |
| `<` | Hohe Priorität (weniger „nice“). |
| `N` | Niedrige Priorität („nice“). |

Die Statusanzeige kann zusätzlich weitere Buchstaben enthalten.

Diese beschreiben besondere Eigenschaften des Prozesses.

Mehr dazu findest du in der Handbuchseite von `ps`.

:::
## Muss ich Zombies sofort beseitigen?

Nein.

Ein **Zombie-Prozess** verbraucht praktisch keine CPU-Zeit und kaum Speicher.

Er existiert lediglich noch als kurzer Eintrag in der Prozesstabelle, bis sein Elternprozess ihn endgültig entfernt.

Erst wenn sich ungewöhnlich viele Zombies ansammeln, deutet das auf einen Programmfehler hin.
:::

---

# Prozesse aller Benutzer anzeigen

Eine besonders häufig verwendete Variante lautet:

```bash
ps aux
```

Die Ausgabe enthält deutlich mehr Informationen:

```bash
[me@linuxbox ~]$ ps aux
```

Dabei werden Prozesse **aller Benutzer** angezeigt.

Interessanterweise besitzen diese Optionen **keinen führenden Bindestrich**.

Hier verwendet `ps` die sogenannte **BSD-Schreibweise**.

Die Linux-Version von `ps` unterstützt sowohl die klassische Unix-Syntax als auch die Syntax verschiedener BSD-Systeme.

Die wichtigsten BSD-Optionen sind:

| Option | Bedeutung |
|--------|-----------|
| `x` | Alle Prozesse des aktuellen Benutzers anzeigen. |
| `a` | Prozesse aller Benutzer anzeigen. |
| `w` | Lange Befehlszeilen vollständig ausgeben. |
| `u` | Ausführliche Informationen anzeigen. |

---

## Zusätzliche Spalten

Mit `ps aux` erscheinen weitere Informationen.

| Spalte | Bedeutung |
|--------|-----------|
| `USER` | Besitzer des Prozesses. |
| `%CPU` | Aktuelle CPU-Auslastung in Prozent. |
| `%MEM` | Belegter Arbeitsspeicher in Prozent. |
| `VSZ` | Größe des virtuellen Speichers. |
| `RSS` | Tatsächlich belegter Arbeitsspeicher (RAM) in Kilobyte. |
| `START` | Zeitpunkt, zu dem der Prozess gestartet wurde. |
| `TIME` | Bisher verbrauchte CPU-Zeit. |

:::
## Virtueller Speicher und RAM

Die Werte `VSZ` und `RSS` werden häufig verwechselt.

`VSZ` (_Virtual Size_) beschreibt den gesamten virtuellen Adressraum eines Prozesses.

`RSS` (_Resident Set Size_) gibt dagegen an, wie viel physischer Arbeitsspeicher (RAM) der Prozess aktuell tatsächlich belegt.

Für die tatsächliche Speicherbelegung ist `RSS` meist die interessantere Größe.
:::

---

## Informationen zu einem einzelnen Prozess

Möchtest du Details zu einem bestimmten Prozess anzeigen, kannst du seine Prozess-ID direkt an `ps` übergeben.

Beispiel:

```bash
[me@linuxbox ~]$ ps uw 44719

USER      PID %CPU %MEM   VSZ  RSS TTY   STAT START TIME COMMAND
me      44719  0.0  0.0 13480 6492 pts/1 S    15:57 0:00 bash
```

Dadurch erhältst du eine ausführliche Momentaufnahme genau dieses einen Prozesses.

Im weiteren Verlauf dieses Kapitels werden wir lernen, wie sich solche Prozesse nicht nur anzeigen, sondern auch gezielt beeinflussen und bei Bedarf beenden lassen.