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