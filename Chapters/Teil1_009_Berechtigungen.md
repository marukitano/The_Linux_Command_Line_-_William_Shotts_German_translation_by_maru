# 9 – Berechtigungen

Betriebssysteme der Unix-Familie unterscheiden sich in einem wichtigen Punkt von klassischen MS-DOS-Systemen:

Sie sind nicht nur **multitaskingfähig**, sondern auch **mehrbenutzerfähig** (_Multi-User-Systeme_).

## Was bedeutet „Mehrbenutzerfähig“?

Ein Mehrbenutzerbetriebssystem ermöglicht es mehreren Personen, denselben Computer gleichzeitig zu verwenden.

Auf einem typischen Heim-PC gibt es zwar meist nur eine Tastatur und einen Bildschirm, trotzdem können mehrere Benutzer gleichzeitig angemeldet sein.

Über das Netzwerk oder das Internet können sich Benutzer beispielsweise per **SSH (Secure Shell)** auf dem Rechner anmelden und dort arbeiten.

Dabei können sie nicht nur Befehle ausführen, sondern – je nach Konfiguration – sogar grafische Programme starten, deren Fenster auf ihrem eigenen Computer erscheinen.

Die Mehrbenutzerfähigkeit ist bei Linux keine spätere Erweiterung, sondern gehört seit den Anfängen zum grundlegenden Design des Betriebssystems.

Das hat historische Gründe.

Als Unix entstand, waren Computer keine persönlichen Geräte.

Sie waren groß, teuer und wurden zentral betrieben.

An Universitäten stand häufig ein leistungsfähiger Großrechner in einem Rechenzentrum, während über den gesamten Campus verteilt zahlreiche Terminals angeschlossen waren.

Alle Benutzer arbeiteten gleichzeitig auf demselben Rechner.

Damit dieses Konzept funktionierte, musste verhindert werden, dass Benutzer sich gegenseitig stören.

Niemand sollte versehentlich Dateien anderer Benutzer verändern oder gar das gesamte System beschädigen können.

Aus diesem Grund besitzt Unix seit jeher ein ausgefeiltes Berechtigungssystem.

## Warum ist das heute noch wichtig?

Auch auf einem Computer, der nur von einer einzigen Person genutzt wird, spielt dieses Sicherheitsmodell eine wichtige Rolle.

Im Alltag arbeitet man normalerweise mit einem gewöhnlichen Benutzerkonto.

Dieses besitzt **nicht** die Berechtigung, wichtige Systemdateien zu verändern.

Administrative Aufgaben werden stattdessen mit einem speziellen Administratorkonto oder temporär über Werkzeuge wie `sudo` ausgeführt.

Dadurch sinkt das Risiko erheblich, versehentlich das Betriebssystem oder wichtige Dateien zu beschädigen.

In diesem Kapitel lernen wir deshalb einen der wichtigsten Bestandteile der Linux-Sicherheit kennen.

Dabei begegnen uns unter anderem folgende Befehle:

- `id` – Informationen über einen Benutzer anzeigen
- `chmod` – Dateiberechtigungen ändern
- `umask` – Standardberechtigungen für neue Dateien festlegen
- `su` – Eine Shell als anderer Benutzer starten
- `sudo` – Einen einzelnen Befehl als anderer Benutzer ausführen
- `chown` – Besitzer einer Datei ändern
- `chgrp` – Gruppenzugehörigkeit einer Datei ändern
- `addgroup` – Benutzer oder Gruppen zum System hinzufügen
- `usermod` – Benutzerkonto ändern
- `passwd` – Passwort eines Benutzers ändern

## Benutzer, Gruppen und alle anderen

Vielleicht erinnerst du dich noch an Kapitel 3.

Damals konnten wir bestimmte Dateien nicht öffnen.

Zum Beispiel:

```bash
[me@linuxbox ~]$ file /etc/shadow
/etc/shadow: regular file, no read permission

[me@linuxbox ~]$ less /etc/shadow
/etc/shadow: Permission denied
```

Der Grund dafür ist einfach:

Als normaler Benutzer besitzen wir **keine Leseberechtigung** für diese Datei.

Und genau das ist beabsichtigt.

Die Datei `/etc/shadow` enthält sicherheitsrelevante Informationen über die Passwörter aller Benutzer des Systems und darf deshalb nur von privilegierten Benutzern gelesen werden.

:::
## Warum existieren `/etc/passwd` und `/etc/shadow`?

Früher waren Passwortinformationen direkt in `/etc/passwd` gespeichert.

Da diese Datei von allen Benutzern gelesen werden können muss, stellte das ein Sicherheitsproblem dar.

Deshalb wurden die Passwort-Hashes später in die geschützte Datei `/etc/shadow` ausgelagert.

Heute enthält `/etc/passwd` nur noch allgemeine Informationen über Benutzerkonten, während `/etc/shadow` ausschließlich für privilegierte Prozesse zugänglich ist.
:::

## Das Unix-Berechtigungsmodell

Das Berechtigungssystem von Unix basiert auf drei einfachen Rollen.

Jede Datei und jedes Verzeichnis besitzt:

- einen **Besitzer** (_Owner_)
- eine **Gruppe** (_Group_)
- **alle übrigen Benutzer** (_Others_)

Der Besitzer entscheidet, wer auf seine Dateien zugreifen darf.

Zusätzlich kann er einer Gruppe bestimmte Rechte einräumen.

Alle übrigen Benutzer fallen in die Kategorie **Others** (manchmal auch **World** genannt).

Dieses einfache Modell bildet bis heute die Grundlage des Linux-Berechtigungssystems.

Im weiteren Verlauf dieses Kapitels werden wir sehen, wie diese Rechte genau funktionieren.

## Informationen über den aktuellen Benutzer

Um Informationen über unser eigenes Benutzerkonto zu erhalten, verwenden wir den Befehl:

```bash
id
```

Beispiel:

```bash
[me@linuxbox ~]$ id
uid=500(me) gid=500(me) groups=500(me)
```

Schauen wir uns die einzelnen Bestandteile an.

Beim Anlegen eines Benutzerkontos vergibt Linux eine eindeutige **Benutzer-ID** (_User ID_, kurz **UID**).

Damit Menschen nicht mit Zahlen arbeiten müssen, wird diese UID zusätzlich einem Benutzernamen zugeordnet.

Außerdem besitzt jeder Benutzer eine **primäre Gruppe**, die durch die **Group ID (GID)** beschrieben wird.

Zusätzlich kann ein Benutzer Mitglied beliebig vieler weiterer Gruppen sein.

Unter Ubuntu könnte die Ausgabe beispielsweise so aussehen:

```bash
[me@linuxbox ~]$ id
uid=1000(me) gid=1000(me)
groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),108(lpadmin),114(admin),1000(me)
```

Hier fällt auf, dass deutlich mehr Gruppen aufgeführt werden.

Das liegt daran, dass Ubuntu viele Systemberechtigungen über Gruppen organisiert.

So erhalten Mitglieder bestimmter Gruppen beispielsweise Zugriff auf

- Audiogeräte,
- Drucker,
- serielle Schnittstellen,
- CD/DVD-Laufwerke
- oder andere Hardware.

Die eigentlichen UID- und GID-Nummern unterscheiden sich ebenfalls zwischen Linux-Distributionen.

Fedora vergab Benutzerkonten früher ab UID **500**, während Ubuntu traditionell bei **1000** beginnt.

Die konkrete Zahl ist dabei nicht wichtig.

Entscheidend ist nur, dass jede UID eindeutig ist.

## Wo werden Benutzer gespeichert?

Auch diese Informationen stammen – wie so vieles unter Linux – aus einfachen Textdateien.

Die wichtigsten sind:

| Datei | Inhalt |
|--------|--------|
| `/etc/passwd` | Benutzerkonten |
| `/etc/group` | Gruppen |
| `/etc/shadow` | Passwort-Hashes und Passwortinformationen |

Beim Anlegen oder Ändern eines Benutzerkontos werden diese Dateien automatisch aktualisiert.

Für jedes Benutzerkonto enthält `/etc/passwd` unter anderem:

- den Benutzernamen,
- die UID,
- die primäre GID,
- den vollständigen Namen des Benutzers,
- das Home-Verzeichnis,
- sowie die Standard-Shell.

Wenn du einen Blick in `/etc/passwd` oder `/etc/group` wirfst, wirst du feststellen, dass dort weit mehr Benutzer existieren als nur dein eigenes Konto.

Neben dem **Superuser** (`root`, immer **UID 0**) findest du zahlreiche weitere Systembenutzer.

Diese gehören meist nicht zu echten Personen.

Stattdessen werden sie von Diensten und Hintergrundprogrammen verwendet.

Im nächsten Kapitel über Prozesse werden wir einigen dieser "Benutzer" wieder begegnen.

:::
## Eine Gruppe pro Benutzer

Früher war es üblich, alle normalen Benutzer einer gemeinsamen Gruppe wie `users` zuzuordnen.

Heute verfolgen die meisten Linux-Distributionen einen anderen Ansatz.

Für jeden Benutzer wird automatisch eine eigene Gruppe mit demselben Namen erstellt.

Ein Benutzer namens

```text
maru
```

besitzt daher häufig auch eine Gruppe

```text
maru
```

als primäre Gruppe.

Dieses sogenannte **User Private Group**-Konzept vereinfacht viele Berechtigungsregeln und hat sich heute weitgehend durchgesetzt.
:::

## Lesen, Schreiben und Ausführen

Das Unix-Berechtigungssystem basiert auf drei grundlegenden Rechten:

- **Lesen** (_Read_)
- **Schreiben** (_Write_)
- **Ausführen** (_Execute_)

Diese Rechte können unabhängig voneinander für verschiedene Benutzer vergeben werden.

Schauen wir uns zunächst ein einfaches Beispiel an.

```bash
[me@linuxbox ~]$ touch foo.txt
[me@linuxbox ~]$ ls -l foo.txt
-rw-rw-r-- 1 me me 0 2016-03-06 14:52 foo.txt
```

Der interessante Teil befindet sich ganz am Anfang der Ausgabe:

```text
-rw-rw-r--
```

Diese zehn Zeichen beschreiben den **Dateityp** und die **Berechtigungen** der Datei.

## Der Dateityp

Das erste Zeichen gibt an, **welchen Typ** die Datei besitzt.

Die häufigsten Dateitypen sind:

| Zeichen | Bedeutung |
|----------|-----------|
| `-` | Normale Datei |
| `d` | Verzeichnis |
| `l` | Symbolischer Link |
| `c` | Zeichenorientierte Gerätedatei (_Character Device_), z. B. Terminal oder `/dev/null` |
| `b` | Blockorientierte Gerätedatei (_Block Device_), z. B. Festplatten, SSDs oder DVD-Laufwerke |

### Symbolische Links

Bei symbolischen Links fällt häufig Folgendes auf:

```text
lrwxrwxrwx
```

Die Berechtigungen sehen so aus, als dürfte jeder alles.

Tatsächlich sind diese Werte jedoch **ohne Bedeutung**.

Entscheidend sind immer die Berechtigungen der Datei oder des Verzeichnisses, auf das der symbolische Link verweist.

Deshalb besitzen symbolische Links praktisch immer dieselben scheinbaren Rechte:

```text
rwxrwxrwx
```

:::
## Warum zeigt `ls` trotzdem Berechtigungen an?

Historisch besitzt auch ein symbolischer Link einen sogenannten _Mode_.

Linux ignoriert diesen jedoch beim Zugriff.

Aus Gründen der Kompatibilität zeigt `ls` trotzdem die bekannten Zeichen `rwxrwxrwx` an.

Für die tatsächlichen Zugriffsrechte zählt ausschließlich das Ziel des Links.
:::

## Die neun Berechtigungszeichen

Nach dem Dateityp folgen neun weitere Zeichen:

```text
-rw-rw-r--
```

Diese werden immer in drei Dreiergruppen aufgeteilt:

```text
-rw- rw- r--
 ^^^ ^^^ ^^^
Owner Group Others
```

Sie beschreiben die Rechte für

- den **Besitzer** (_Owner_)
- die **Gruppe** (_Group_)
- **alle übrigen Benutzer** (_Others_)

Jede Gruppe besteht wiederum aus drei möglichen Berechtigungen:

```text
rwx
```

Dabei bedeuten:

- `r` → Lesen (_Read_)
- `w` → Schreiben (_Write_)
- `x` → Ausführen (_Execute_)

Fehlt ein Recht, erscheint an seiner Stelle ein Minuszeichen (`-`).

Beispielsweise bedeutet

```text
rw-
```

dass gelesen und geschrieben werden darf, das Ausführen jedoch nicht erlaubt ist.

---

## Bedeutung der einzelnen Berechtigungen

Die Bedeutung von `r`, `w` und `x` unterscheidet sich leicht zwischen Dateien und Verzeichnissen.

| Recht | Dateien | Verzeichnisse |
|--------|----------|---------------|
| `r` | Datei lesen | Inhalt des Verzeichnisses auflisten (`ls`) |
| `w` | Datei verändern oder überschreiben | Dateien anlegen, löschen oder umbenennen (zusammen mit `x`) |
| `x` | Datei als Programm ausführen | Verzeichnis betreten (`cd`) und auf darin enthaltene Dateien zugreifen |

### Leserecht (`r`)

Bei einer Datei bedeutet `r`, dass ihr Inhalt gelesen werden darf.

Bei einem Verzeichnis erlaubt `r`, dessen Inhalt aufzulisten.

Ohne zusätzliches `x` erhältst du allerdings meist nur die Dateinamen, nicht aber weitere Informationen wie Größe oder Berechtigungen.

### Schreibrecht (`w`)

Bei einer Datei erlaubt `w`, ihren Inhalt zu verändern.

Interessanterweise genügt dieses Recht **nicht**, um die Datei umzubenennen oder zu löschen.

Ob eine Datei gelöscht werden darf, entscheidet nämlich das Verzeichnis, in dem sie liegt.

Bei Verzeichnissen erlaubt `w` (zusammen mit `x`)

- neue Dateien anzulegen,
- Dateien zu löschen,
- und Dateien umzubenennen.

:::
## Warum löscht man eine Datei über das Verzeichnis?

Das wirkt zunächst ungewohnt.

Unter Unix wird beim Löschen nämlich nicht die Datei selbst verändert.

Stattdessen wird lediglich ihr **Eintrag im Verzeichnis** entfernt.

Deshalb benötigt `rm` Schreibrechte auf dem Verzeichnis – nicht auf der Datei.

Diese Besonderheit sorgt bei Linux-Einsteigern häufig für Verwirrung.
:::

### Ausführungsrecht (`x`)

Bei Dateien erlaubt `x`, die Datei als Programm zu starten.

Handelt es sich um ein Shell- oder Python-Skript, muss die Datei zusätzlich lesbar sein, damit der Interpreter ihren Inhalt überhaupt laden kann.

Bei Verzeichnissen besitzt `x` eine völlig andere Bedeutung.

Hier erlaubt es,

- das Verzeichnis zu betreten (`cd`),
- auf Dateien innerhalb des Verzeichnisses zuzugreifen,
- sowie Befehle wie `cp`, `mv` oder `rm` auf diese Dateien anzuwenden.

Das Ausführungsrecht auf Verzeichnissen wird deshalb manchmal auch als **Durchsuchungsrecht** (_Search Permission_) bezeichnet.

## Beispiele

Ein paar typische Berechtigungen lassen sich nun leicht lesen.

| Berechtigungen | Bedeutung |
|----------------|-----------|
| `-rwx------` | Nur der Besitzer darf lesen, schreiben und ausführen. |
| `-rw-------` | Nur der Besitzer darf lesen und schreiben. |
| `-rw-r--r--` | Besitzer: lesen und schreiben. Gruppe und andere: nur lesen. |
| `-rwxr-xr-x` | Besitzer: lesen, schreiben und ausführen. Alle anderen: lesen und ausführen. |
| `-rw-rw----` | Besitzer und Gruppe dürfen lesen und schreiben. Andere haben keinen Zugriff. |
| `lrwxrwxrwx` | Symbolischer Link. Die angezeigten Berechtigungen sind bedeutungslos; maßgeblich sind die Rechte des Ziels. |
| `drwxrwx---` | Besitzer und Gruppe dürfen das Verzeichnis betreten sowie Dateien anlegen, löschen und umbenennen. |
| `drwxr-x---` | Besitzer darf alles. Gruppenmitglieder dürfen das Verzeichnis betreten und lesen, aber keine Dateien anlegen, löschen oder umbenennen. |

:::
## Berechtigungen lesen lernen

Anfangs wirken Zeichenfolgen wie

```text
-rwxr-xr-x
```

ziemlich kryptisch.

Mit etwas Übung lassen sie sich jedoch auf einen Blick erkennen.

Ein guter Trick besteht darin, sie immer in vier Teile zu zerlegen:

```text
- | rwx | r-x | r-x
```

1. **Dateityp**
2. **Besitzer**
3. **Gruppe**
4. **Andere**

Fast alle Linux-Werkzeuge verwenden genau dieses Schema.

Es lohnt sich also, sich früh daran zu gewöhnen.
:::

## `chmod` – Dateiberechtigungen ändern

Um die Berechtigungen einer Datei oder eines Verzeichnisses zu ändern, verwendet man den Befehl `chmod`.

Dabei gilt eine wichtige Regel:

Nur

- der **Besitzer** einer Datei
- oder der **Superuser** (`root`)

dürfen ihre Berechtigungen ändern.

`chmod` unterstützt zwei verschiedene Schreibweisen:

1. **Oktale Schreibweise** (Zahlen wie `755` oder `644`)
2. **Symbolische Schreibweise** (z. B. `u+x` oder `go=rw`)

Beginnen wir mit der oktalen Schreibweise.

## Was ist eigentlich Oktal?

Bevor wir verstehen können, warum Berechtigungen häufig mit Zahlen wie

```text
755
```

oder

```text
644
```

geschrieben werden, müssen wir einen kurzen Blick auf Zahlensysteme werfen.

Wir Menschen verwenden im Alltag das **Dezimalsystem** (_Basis 10_).

Das liegt vermutlich daran, dass wir zehn Finger besitzen.

Wir zählen also so:

```text
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ...
```

Computer arbeiten dagegen intern ausschließlich mit zwei Zuständen:

- an
- aus

Deshalb verwenden sie das **Binärsystem** (_Basis 2_).

Dort existieren nur die Ziffern

```text
0 und 1
```

Gezählt wird beispielsweise so:

```text
0
1
10
11
100
101
110
111
1000
...
```

Ein weiteres Zahlensystem ist das **Oktalsystem** (_Basis 8_).

Es verwendet nur die Ziffern

```text
0 bis 7
```

und zählt deshalb so:

```text
0, 1, 2, 3, 4, 5, 6, 7, ...
```

Daneben gibt es noch das **Hexadezimalsystem** (_Basis 16_).

Es verwendet

```text
0–9 sowie A–F
```

und zählt beispielsweise:

```text
0, 1, 2, ..., 9, A, B, C, D, E, F, 10, 11 ...
```

---

## Warum verwendet Linux überhaupt Oktal?

Auf den ersten Blick wirken Zahlensysteme wie Oktal oder Hexadezimal ziemlich unnötig.

Warum nicht einfach alles dezimal schreiben?

Der Grund liegt in der Darstellung von **Binärdaten**.

Viele Informationen im Computer bestehen intern lediglich aus einzelnen Bits.

Ein gutes Beispiel ist eine Farbe auf dem Bildschirm.

Ein Pixel besteht meist aus

- 8 Bit Rot
- 8 Bit Grün
- 8 Bit Blau

Zusammen ergibt das 24 Bit.

Eine Farbe könnte intern so aussehen:

```text
010000110110111111001101
```

Das lässt sich nur schwer lesen.

Im Hexadezimalsystem wird dieselbe Zahl wesentlich kompakter dargestellt:

```text
436FCD
```

Hier erkennt man sogar direkt die drei Farbanteile:

- Rot → `43`
- Grün → `6F`
- Blau → `CD`

Hexadezimal wird deshalb bis heute häufig verwendet, etwa für Farben im Web oder Speicheradressen.

## Warum gerade Oktal für Berechtigungen?

Während Hexadezimal hervorragend zu Vierergruppen von Bits passt, eignet sich **Oktal** perfekt für **Dreiergruppen**.

Und genau aus drei Bits besteht jede Berechtigungsgruppe.

Schauen wir uns die drei Berechtigungen noch einmal an:

```text
r w x
```

Jede Berechtigung kann entweder gesetzt oder nicht gesetzt sein.

Das ergibt genau drei Bits.

| Oktal | Binär | Berechtigungen |
|-------:|:-----:|----------------|
| 0 | `000` | `---` |
| 1 | `001` | `--x` |
| 2 | `010` | `-w-` |
| 3 | `011` | `-wx` |
| 4 | `100` | `r--` |
| 5 | `101` | `r-x` |
| 6 | `110` | `rw-` |
| 7 | `111` | `rwx` |

Deshalb kann jede Dreiergruppe der Berechtigungen durch **eine einzige Oktalziffer** dargestellt werden.

## Ein Beispiel

Unsere Datei besitzt zunächst folgende Rechte:

```bash
[me@linuxbox ~]$ touch foo.txt
[me@linuxbox ~]$ ls -l foo.txt
-rw-rw-r-- 1 me me 0 2016-03-06 14:52 foo.txt
```

Nun ändern wir die Berechtigungen:

```bash
[me@linuxbox ~]$ chmod 600 foo.txt
```

Danach sieht die Ausgabe so aus:

```bash
[me@linuxbox ~]$ ls -l foo.txt
-rw------- 1 me me 0 2016-03-06 14:52 foo.txt
```

Die Zahl

```text
600
```

bedeutet:

```text
6   0   0
│   │   │
│   │   └── Others
│   └────── Group
└────────── Owner
```

Schauen wir uns die erste Ziffer an:

```text
6
```

Aus der Tabelle wissen wir:

```text
6 = rw-
```

Die übrigen beiden Ziffern sind

```text
0 = ---
```

Somit ergibt sich:

```text
rw- --- ---
```

also genau

```text
-rw-------
```

Nur der Besitzer darf lesen und schreiben.

Alle anderen besitzen keinerlei Rechte.

:::
## Die fünf wichtigsten Zahlen

Zum Glück muss man sich nicht alle acht Kombinationen merken.

In der Praxis begegnen dir fast ausschließlich diese fünf:

| Oktal | Berechtigungen |
|-------:|----------------|
| `7` | `rwx` |
| `6` | `rw-` |
| `5` | `r-x` |
| `4` | `r--` |
| `0` | `---` |

Aus ihnen lassen sich praktisch alle üblichen Berechtigungen zusammensetzen.
:::

---

## Symbolische Schreibweise

Neben Zahlen unterstützt `chmod` auch eine besser lesbare Schreibweise.

Dabei besteht jede Angabe aus drei Teilen:

1. **Wer** soll geändert werden?
2. **Welche Operation** soll durchgeführt werden?
3. **Welche Berechtigung** betrifft die Änderung?

### Wer?

| Symbol | Bedeutung |
|--------|-----------|
| `u` | Besitzer (_User_) |
| `g` | Gruppe (_Group_) |
| `o` | Andere (_Others_) |
| `a` | Alle (_All_) |

Wird kein Buchstabe angegeben, verwendet `chmod` automatisch `a` (alle).

### Welche Operation?

| Symbol | Bedeutung |
|--------|-----------|
| `+` | Berechtigung hinzufügen |
| `-` | Berechtigung entfernen |
| `=` | Genau diese Berechtigungen setzen und alle anderen entfernen |

### Welche Berechtigungen?

Wie gewohnt werden die drei Buchstaben verwendet:

```text
r  w  x
```

---

## Beispiele

| Befehl | Bedeutung |
|--------|-----------|
| `chmod u+x datei` | Besitzer erhält Ausführungsrecht. |
| `chmod u-x datei` | Ausführungsrecht des Besitzers entfernen. |
| `chmod +x datei` | Alle erhalten Ausführungsrecht (entspricht `a+x`). |
| `chmod o-rw datei` | Anderen Benutzern Lese- und Schreibrechte entziehen. |
| `chmod go=rw datei` | Gruppe und Andere erhalten genau Lese- und Schreibrechte. Vorhandene Ausführungsrechte werden entfernt. |
| `chmod u+x,go=rx datei` | Besitzer erhält zusätzlich Ausführungsrecht. Gruppe und Andere erhalten genau Lese- und Ausführungsrechte. |

Mehrere Änderungen können durch Kommas getrennt werden.

---

## Oktal oder symbolisch?

Beide Schreibweisen sind gleichwertig.

Viele Administratoren verwenden lieber die Oktalschreibweise:

```bash
chmod 755 script.sh
chmod 644 dokument.txt
```

Andere bevorzugen die symbolische Schreibweise:

```bash
chmod u+x script.sh
```

Der größte Vorteil der symbolischen Schreibweise besteht darin, dass sich **einzelne Berechtigungen ändern lassen**, ohne alle übrigen Rechte neu festlegen zu müssen.

Beispielsweise ergänzt

```bash
chmod u+x script.sh
```

lediglich das Ausführungsrecht des Besitzers.

Alle anderen Berechtigungen bleiben unverändert.

:::
## Vorsicht bei `chmod -R`

`chmod` besitzt die Option

```bash
-R
```

(_rekursiv_).

Damit werden die Berechtigungen aller Dateien und Unterverzeichnisse geändert.

Das klingt praktisch, kann aber leicht zu unerwarteten Ergebnissen führen.

Dateien und Verzeichnisse benötigen nämlich oft unterschiedliche Berechtigungen.

Während Programme häufig ausführbar sein müssen, gilt das für normale Textdateien meist nicht.

Verwende `chmod -R` deshalb mit Bedacht und prüfe genau, welche Dateien betroffen sind.
:::

## Dateiberechtigungen in grafischen Dateimanagern

Nachdem wir nun wissen, wie Dateiberechtigungen funktionieren, können wir auch die entsprechenden Dialoge grafischer Dateimanager besser verstehen.

Sowohl **Files (GNOME)** als auch **Dolphin (KDE)** bieten einen Eigenschaften-Dialog für Dateien und Verzeichnisse.

Dazu genügt ein Rechtsklick auf eine Datei oder ein Verzeichnis und anschließend **Eigenschaften**.

![Abbildung 2: GNOME Zugriffsrechtedialog.](../Images/kap9_1.png)

Hier lassen sich die Berechtigungen für

- den **Besitzer**,
- die **Gruppe**
- und **alle anderen Benutzer**

komfortabel anzeigen und – je nach Dateimanager – auch ändern.

Die grafische Oberfläche verwendet dabei dasselbe Berechtigungssystem wie `chmod`.

Es handelt sich lediglich um eine andere Darstellung derselben Rechte.

:::
## GUI oder Terminal?

Für gelegentliche Änderungen ist der grafische Eigenschaften-Dialog völlig ausreichend.

Wer jedoch häufiger mit Linux arbeitet oder viele Dateien gleichzeitig bearbeiten möchte, wird meist schneller mit `chmod` arbeiten.

Gerade in Shell-Skripten oder bei der Administration mehrerer Systeme führt ohnehin kein Weg an der Kommandozeile vorbei.
:::

---

# `umask` – Standardberechtigungen festlegen

Bisher haben wir gesehen, wie sich Berechtigungen **nachträglich** mit `chmod` ändern lassen.

Doch welche Berechtigungen erhält eine Datei eigentlich **beim Erstellen**?

Genau dafür gibt es den Befehl

```bash
umask
```

Der Name **Umask** stammt von _User Mask_.

Anstatt festzulegen, welche Berechtigungen eine neue Datei erhalten soll, arbeitet die Umask genau umgekehrt: Sie beschreibt, **welche Berechtigungen entfernt werden**.

Man kann sie sich wie eine Schablone vorstellen, die bestimmte Rechte "abdeckt" (maskiert), bevor die Datei angelegt wird.

## Die aktuelle Umask anzeigen

Zunächst löschen wir eine eventuell vorhandene Datei:

```bash
[me@linuxbox ~]$ rm -f foo.txt
```

Nun zeigen wir die aktuelle Umask an:

```bash
[me@linuxbox ~]$ umask
0002
```

Die Ausgabe erfolgt – wie bei `chmod` – in Oktalschreibweise.

Erstellen wir nun eine neue Datei:

```bash
[me@linuxbox ~]$ > foo.txt
```

und betrachten ihre Berechtigungen:

```bash
[me@linuxbox ~]$ ls -l foo.txt
-rw-rw-r-- 1 me me 0 2025-03-06 14:53 foo.txt
```

Die Datei besitzt also:

```text
rw- rw- r--
```

Der Besitzer und die Gruppe dürfen lesen und schreiben.

Alle anderen besitzen nur Leserechte.

---

## Die Umask ändern

Setzen wir die Umask nun testweise auf

```text
0000
```

```bash
[me@linuxbox ~]$ rm foo.txt
[me@linuxbox ~]$ umask 0000
[me@linuxbox ~]$ > foo.txt
[me@linuxbox ~]$ ls -l foo.txt
-rw-rw-rw- 1 me me 0 2025-03-06 14:58 foo.txt
```

Jetzt dürfen plötzlich **alle Benutzer schreiben**.

Warum?

Weil die Umask diesmal keinerlei Rechte entfernt.

---

## Wie funktioniert die Umask?

Neue Dateien starten normalerweise mit den Rechten

```text
rw- rw- rw-
```

Die Umask entfernt anschließend einzelne Berechtigungen.

Schauen wir uns die Umask

```text
0002
```

an.

| Ausgangsrechte | `rw- rw- rw-` |
|----------------|---------------|
| Umask | `000 000 000 010` |
| Ergebnis | `rw- rw- r--` |

Dort, wo in der Umask eine **1** steht, verschwindet das entsprechende Recht.

In diesem Beispiel wird lediglich das Schreibrecht für **Others** entfernt.

Betrachten wir nun die übliche Umask

```text
0022
```

| Ausgangsrechte | `rw- rw- rw-` |
|----------------|---------------|
| Umask | `000 000 010 010` |
| Ergebnis | `rw- r-- r--` |

Jetzt verlieren sowohl

- die Gruppe
- als auch alle anderen

ihr Schreibrecht.

:::
## Ein Merksatz zur Umask

`chmod` beschreibt die Berechtigungen, **die eine Datei haben soll**.

`umask` beschreibt dagegen die Berechtigungen, **die entfernt werden sollen**.

Viele Linux-Einsteiger verwechseln diese beiden Konzepte zunächst.

Ein einfacher Merksatz lautet deshalb:

**`chmod` gibt Rechte. `umask` nimmt Rechte weg.**
:::

Du kannst ruhig etwas mit verschiedenen Werten experimentieren – zum Beispiel mit `0007` oder `0077` –, um ein Gefühl dafür zu bekommen.

Vergiss anschließend nicht, den ursprünglichen Zustand wiederherzustellen:

```bash
[me@linuxbox ~]$ rm foo.txt
[me@linuxbox ~]$ umask 0002
```

In den meisten Fällen musst du die Umask übrigens gar nicht ändern.

Die Standardwerte deiner Linux-Distribution sind für den Alltag meist gut gewählt.

Lediglich in besonders sicherheitskritischen Umgebungen wird die Umask häufig angepasst.

# Besondere Berechtigungen

Bisher haben wir Berechtigungen immer mit **drei Oktalziffern** beschrieben.

Genauer betrachtet besitzt der Berechtigungsmodus jedoch **vier** Stellen.

Die zusätzliche Stelle steht für einige besondere Berechtigungen, die deutlich seltener verwendet werden.

Sie sind:

- **setuid** (`4000`)
- **setgid** (`2000`)
- **Sticky Bit** (`1000`)

## `setuid`

Das **setuid-Bit** besitzt den Oktalwert

```text
4000
```

Es kann auf ausführbaren Programmen gesetzt werden.

Wird ein solches Programm gestartet, läuft es **nicht** mit den Rechten des aufrufenden Benutzers, sondern mit den Rechten des Dateibesitzers.

Am häufigsten gehört dieser Besitzer dem Benutzer

```text
root
```

an.

Dadurch kann ein normales Benutzerprogramm kurzzeitig administrative Aufgaben erledigen.

Bekannte Programme wie

```text
passwd
```

verwenden dieses Prinzip, damit jeder Benutzer sein eigenes Passwort ändern kann, obwohl dafür eigentlich Schreibzugriff auf geschützte Systemdateien erforderlich ist.

Da Programme mit `setuid` erhöhte Rechte besitzen, sollten sie äußerst sparsam eingesetzt werden.

---

## `setgid`

Das **setgid-Bit**

```text
2000
```

funktioniert ähnlich, wirkt jedoch auf die **Gruppe**.

Bei Programmen übernimmt der Prozess die Gruppen-ID des Dateibesitzers.

Noch häufiger wird `setgid` jedoch auf **Verzeichnissen** verwendet.

Neue Dateien erhalten dann automatisch dieselbe Gruppe wie das Verzeichnis – unabhängig davon, welche primäre Gruppe ihr Ersteller besitzt.

Das ist besonders praktisch in gemeinsam genutzten Projektverzeichnissen.

---

## Das Sticky Bit

Das **Sticky Bit**

```text
1000
```

hat heute fast ausschließlich auf **Verzeichnissen** Bedeutung.

Ist es gesetzt, dürfen Dateien nur gelöscht oder umbenannt werden von

- ihrem Besitzer,
- dem Besitzer des Verzeichnisses
- oder `root`.

Ein klassisches Beispiel ist

```text
/tmp
```

Dort dürfen alle Benutzer Dateien anlegen.

Ohne Sticky Bit könnte jedoch jeder die Dateien anderer Benutzer löschen.

Deshalb besitzt `/tmp` üblicherweise das Sticky Bit.

:::
## Historischer Hintergrund

Ursprünglich hatte das Sticky Bit auf ausführbaren Programmen eine völlig andere Funktion.

Es sorgte dafür, dass Programme nach dem Beenden im Arbeitsspeicher blieben und dadurch schneller erneut gestartet werden konnten.

Moderne Linux-Systeme ignorieren dieses Verhalten.

Heute spielt das Sticky Bit praktisch nur noch bei Verzeichnissen eine Rolle.
:::

---

## Besondere Berechtigungen setzen

Die symbolische Schreibweise ist meist am einfachsten.

### `setuid`

```bash
chmod u+s programm
```

### `setgid`

```bash
chmod g+s verzeichnis
```

### Sticky Bit

```bash
chmod +t verzeichnis
```

---

## Besondere Berechtigungen erkennen

Auch `ls -l` zeigt diese Berechtigungen an.

Ein Programm mit `setuid`:

```text
-rwsr-xr-x
```

Das `s` ersetzt das Ausführungsrecht des Besitzers.

Ein Verzeichnis mit `setgid`:

```text
drwxrwsr-x
```

Hier ersetzt das `s` das Ausführungsrecht der Gruppe.

Ein Verzeichnis mit Sticky Bit:

```text
drwxrwxrwt
```

Das `t` erscheint an der Stelle des Ausführungsrechts für **Others**.

:::
## Diese Rechte brauchst du nicht auswendig zu lernen

Im normalen Linux-Alltag wirst du hauptsächlich mit den klassischen Berechtigungen (`r`, `w` und `x`) arbeiten.

`setuid`, `setgid` und das Sticky Bit begegnen dir deutlich seltener.

Es genügt zunächst zu wissen, **dass** sie existieren und welchen grundsätzlichen Zweck sie erfüllen.

Später, wenn du Systeme administrierst oder Server betreust, wirst du ihnen automatisch häufiger begegnen.
:::