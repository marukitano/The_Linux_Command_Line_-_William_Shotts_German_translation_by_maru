# 11 – Die Umgebung

Wie wir bereits besprochen haben, verwaltet die Shell während einer Shell-Sitzung eine Sammlung von Informationen, die als **Umgebung** (_Environment_) bezeichnet wird.

Programme verwenden die dort gespeicherten Daten, um Informationen über die Konfiguration des Systems zu erhalten. Die meisten Programme speichern ihre Einstellungen zwar in Konfigurationsdateien, manche Programme berücksichtigen jedoch zusätzlich Werte aus der Umgebung und passen ihr Verhalten entsprechend an.

Wenn wir verstehen, wie diese Umgebung funktioniert, können wir sie nutzen, um unsere Shell an unsere eigenen Bedürfnisse anzupassen.

In diesem Kapitel beschäftigen wir uns mit folgenden Befehlen:

| Befehl | Beschreibung |
| ------ | ------------ |
| `printenv` | Zeigt einen Teil oder die gesamte Umgebung an. |
| `set` | Zeigt beziehungsweise verändert Shell-Einstellungen und Variablen. |
| `export` | Exportiert Variablen in die Umgebung nachfolgend gestarteter Programme. |
| `alias` | Erstellt einen Alias für einen Befehl. |
| `source` | Führt Befehle aus einer Datei in der aktuellen Shell aus. |

---

# Was wird in der Umgebung gespeichert?

Bash verwaltet im Wesentlichen zwei Arten von Variablen:

- **Shell-Variablen**
- **Umgebungsvariablen** (_Environment Variables_)

Auf den ersten Blick sehen beide nahezu gleich aus.

Shell-Variablen gehören zunächst nur zur aktuell laufenden Bash-Instanz.

Umgebungsvariablen dagegen gehören zur Umgebung eines Prozesses und werden an daraus gestartete Kindprozesse weitergegeben.

Zusätzlich zu Variablen verwaltet die Shell noch weitere programmatische Informationen, darunter **Aliase** und **Shell-Funktionen**.

Aliase haben wir bereits in Kapitel 5 kennengelernt. Shell-Funktionen, die eng mit Shell-Skripten zusammenhängen, behandeln wir später in Teil 4.

:::note
## Shell-Variable oder Umgebungsvariable?

Der entscheidende Unterschied wird besonders wichtig, sobald Prozesse weitere Prozesse starten.

Eine normale Shell-Variable wie

```bash
foo="bar"
```

existiert zunächst nur in der aktuellen Shell.

Mit

```bash
export foo
```

wird sie exportiert. Programme, die anschließend von dieser Shell gestartet werden, erhalten `foo` dann als Teil ihrer Umgebung.

Wir werden uns das weiter unten praktisch ansehen.
:::

---

# Die Umgebung untersuchen

Um herauszufinden, was in unserer Umgebung gespeichert ist, können wir unter Bash unter anderem die Builtins `set` und `export` sowie das Programm `printenv` verwenden.

`set` zeigt ohne Argumente unter anderem Shell-Variablen und Umgebungsvariablen sowie definierte Shell-Funktionen an.

`printenv` konzentriert sich dagegen auf die Umgebungsvariablen.

Da die Ausgabe ziemlich lang sein kann, leiten wir sie am besten an `less` weiter:

```bash
printenv | less
```

Die Ausgabe könnte beispielsweise so aussehen:

```text
USER=me
PAGER=less
PATH=/home/me/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/home/me
LANG=de_CH.UTF-8
HOME=/home/me
SHLVL=2
LOGNAME=me
...
```

Was wir hier sehen, ist eine Liste von Umgebungsvariablen und ihren jeweiligen Werten.

Zum Beispiel enthält die Variable

```text
USER
```

unseren Benutzernamen.

Mit `printenv` können wir auch gezielt den Wert einer einzelnen Variable anzeigen:

```bash
printenv USER
```

Ausgabe:

```text
me
```

Der Befehl `set` zeigt ohne Optionen oder Argumente deutlich mehr an:

```bash
set | less
```

Dazu gehören Shell-Variablen, Umgebungsvariablen und definierte Shell-Funktionen.

Eine weitere Möglichkeit, den Inhalt einer Variable anzusehen, kennen wir bereits:

```bash
echo $HOME
```

Ausgabe:

```text
/home/me
```

:::note
## `$HOME` und `HOME`

`HOME` ist der Name der Variable.

Mit

```bash
$HOME
```

fordern wir die Shell auf, den Wert dieser Variable einzusetzen.

Dieser Vorgang heißt **Parameter Expansion** und wurde bereits in Kapitel 7 behandelt.
:::

Ein Bestandteil unserer Shell-Konfiguration wird weder von `set` noch von `printenv` als einfache Umgebungsvariable dargestellt: unsere **Aliase**.

Diese können wir anzeigen, indem wir `alias` ohne Argumente aufrufen:

```bash
alias
```

Beispielsweise:

```text
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias vi='vim'
```

Die tatsächliche Liste hängt natürlich von deiner Distribution und deiner persönlichen Konfiguration ab.

---

# Einige interessante Variablen

Die Umgebung enthält eine ganze Reihe von Variablen.

Welche davon vorhanden sind und welche Werte sie besitzen, hängt von Distribution, Desktop-Umgebung, Shell und persönlicher Konfiguration ab.

Einige Variablen begegnen uns jedoch besonders häufig:

| Variable | Inhalt |
| -------- | ------ |
| `DISPLAY` | Bezeichnet unter X11 das Display, auf dem grafische Programme dargestellt werden. Häufig ist der Wert beispielsweise `:0`. |
| `WAYLAND_DISPLAY` | Bezeichnet bei einer Wayland-Sitzung das verwendete Wayland-Display, beispielsweise `wayland-0`. |
| `EDITOR` | Legt fest, welcher Texteditor von Programmen standardmäßig verwendet werden soll. |
| `SHELL` | Enthält normalerweise den Pfad zur Login-Shell des Benutzers. |
| `HOME` | Pfad unseres Home-Verzeichnisses. |
| `LANG` | Legt die grundlegenden Locale-Einstellungen fest, darunter Sprache und Zeichenkodierung. |
| `OLDPWD` | Das vorherige Arbeitsverzeichnis. |
| `PAGER` | Programm, das zur seitenweisen Darstellung längerer Ausgaben verwendet werden soll, häufig `less`. |
| `PATH` | Eine durch Doppelpunkte getrennte Liste von Verzeichnissen, in denen nach ausführbaren Programmen gesucht wird. |
| `PS1` | Steht für „Prompt String 1“ und definiert den primären Shell-Prompt. |
| `PWD` | Das aktuelle Arbeitsverzeichnis. |
| `TERM` | Beschreibt den Terminaltyp beziehungsweise dessen Fähigkeiten gegenüber Terminalprogrammen. |
| `TZ` | Kann die für einen Prozess verwendete Zeitzone festlegen oder überschreiben. |
| `USER` | Unser Benutzername. |

Mach dir keine Sorgen, wenn einige dieser Variablen auf deinem System fehlen oder anders aussehen. Die genaue Umgebung unterscheidet sich von System zu System.

:::note
## `DISPLAY` und `WAYLAND_DISPLAY`

Ältere Linux-Literatur erwähnt bei grafischen Sitzungen fast ausschließlich `DISPLAY`, da Linux-Desktops traditionell auf dem **X Window System (X11)** basierten.

Viele moderne Distributionen verwenden inzwischen standardmäßig **Wayland**.

Dort begegnet uns zusätzlich beziehungsweise stattdessen häufig:

```bash
WAYLAND_DISPLAY
```

Mit

```bash
echo $XDG_SESSION_TYPE
```

kannst du auf vielen Desktop-Systemen prüfen, welche Art von Sitzung gerade verwendet wird. Typische Werte sind `x11` und `wayland`.
:::

:::note
## `LANG` ist mehr als nur die Sprache

Eine Locale wie

```text
de_CH.UTF-8
```

beeinflusst nicht nur die Sprache von Programmen.

Locale-Einstellungen können unter anderem bestimmen:

- Zeichenkodierung,
- Sortierreihenfolge,
- Datums- und Zeitdarstellung,
- Zahlenformate,
- und teilweise die Sprache von Meldungen.

`UTF-8` ist heute auf praktisch allen modernen Linux-Systemen die übliche Zeichenkodierung.
:::

---

# Wie entsteht die Umgebung?

Wenn wir uns am System anmelden und Bash gestartet wird, liest die Shell verschiedene Konfigurationsdateien ein.

Diese werden häufig als **Startup Files** bezeichnet.

Ein Teil davon legt globale Einstellungen für alle Benutzer fest. Weitere Dateien in unserem Home-Verzeichnis definieren unsere persönliche Shell-Umgebung.

Welche Dateien tatsächlich gelesen werden, hängt unter anderem davon ab, **wie Bash gestartet wurde**.

Dabei ist eine wichtige Unterscheidung:

- **Login-Shell**
- **Non-Login-Shell**

---

## Login-Shell

Eine Login-Shell ist eine Shell, die als Login-Shell gestartet wurde.

Das geschieht beispielsweise bei bestimmten Konsolen- oder SSH-Anmeldungen oder wenn Bash ausdrücklich als Login-Shell gestartet wird.

Traditionell war dies die Shell, bei der der Benutzer direkt nach Benutzername und Passwort gefragt wurde.

Bash liest bei einer Login-Shell bestimmte Startup-Dateien.

| Datei | Bedeutung |
| ----- | --------- |
| `/etc/profile` | Globale Konfiguration für Login-Shells. |
| `~/.bash_profile` | Persönliche Bash-Konfiguration für Login-Shells. |
| `~/.bash_login` | Wird versucht, wenn `~/.bash_profile` nicht vorhanden ist. |
| `~/.profile` | Wird versucht, wenn weder `~/.bash_profile` noch `~/.bash_login` vorhanden ist. |

Bei den drei persönlichen Dateien gilt also nicht, dass Bash einfach alle nacheinander liest.

Bash verwendet die **erste vorhandene** Datei in dieser Reihenfolge:

```text
~/.bash_profile
~/.bash_login
~/.profile
```

Auf Debian-basierten Distributionen wie Ubuntu ist `~/.profile` besonders verbreitet.

:::note
## Grafischer Login bedeutet nicht automatisch Bash-Login-Shell

Auf modernen Linux-Desktops ist die Situation etwas komplizierter als bei klassischen Unix-Systemen.

Eine grafische Anmeldung bedeutet nicht automatisch, dass dein Terminal anschließend eine Bash-Login-Shell verwendet. Desktop-Umgebungen, Display-Manager, Terminalemulatoren und Distributionen können die Benutzerumgebung auf unterschiedliche Weise aufbauen.

Ob deine aktuelle Bash eine Login-Shell ist, kannst du beispielsweise mit

```bash
shopt -q login_shell && echo "Login-Shell" || echo "Keine Login-Shell"
```

prüfen.
:::

---

## Non-Login-Shell

Eine **Non-Login-Shell** entsteht typischerweise, wenn wir innerhalb einer bereits laufenden grafischen Sitzung einen Terminalemulator öffnen.

Für interaktive Bash-Non-Login-Shells ist insbesondere folgende Datei wichtig:

| Datei | Bedeutung |
| ----- | --------- |
| `/etc/bash.bashrc` | Globale Bash-Konfiguration auf Distributionen, die diese Datei verwenden. |
| `~/.bashrc` | Persönliche Konfiguration für interaktive Bash-Shells. |

Der genaue Name und die globale Konfiguration können sich zwischen Distributionen unterscheiden.

Non-Login-Shells erben außerdem die Umgebungsvariablen ihres Elternprozesses.

Schau ruhig nach, welche dieser Dateien auf deinem System vorhanden sind.

Da viele davon mit einem Punkt beginnen und damit versteckt sind, verwenden wir beispielsweise:

```bash
ls -a ~
```

Die Datei

```text
~/.bashrc
```

ist aus Sicht eines normalen Bash-Benutzers meist eine der wichtigsten Startup-Dateien.

Sie wird standardmäßig von interaktiven Non-Login-Shells gelesen. Viele Konfigurationen für Login-Shells sind außerdem so eingerichtet, dass sie zusätzlich `~/.bashrc` einlesen.

---

# Was steckt in einer Startup-Datei?

Werfen wir einen Blick in eine typische `~/.bash_profile`.

Sie könnte beispielsweise so aussehen:

```bash
# .bash_profile

# Aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH
```

Zeilen, die mit

```text
#
```

beginnen, sind **Kommentare**.

Sie werden von der Shell nicht als Befehle ausgeführt, sondern dienen uns Menschen als Dokumentation.

Der erste interessante Teil ist:

```bash
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
```

Dabei handelt es sich um einen zusammengesetzten `if`-Befehl.

Mit solchen Konstruktionen werden wir uns beim Shell-Scripting in Teil 4 ausführlich beschäftigen.

Für den Moment können wir diesen Abschnitt ungefähr so lesen:

**Wenn die Datei `~/.bashrc` existiert, lies `~/.bashrc` in die aktuelle Shell ein.**

Hier sehen wir also, wie eine Login-Shell zusätzlich die Einstellungen aus `~/.bashrc` übernehmen kann.

:::note
## Was bedeutet der einzelne Punkt?

Die Zeile

```bash
. ~/.bashrc
```

ist die kurze POSIX-Schreibweise für das Einlesen einer Datei in die aktuelle Shell.

Unter Bash können wir verständlicher auch schreiben:

```bash
source ~/.bashrc
```

Beide Varianten führen die Befehle aus der Datei **in der aktuellen Shell** aus.

Warum das wichtig ist, sehen wir später noch.
:::

---

# Die Variable `PATH`

Der nächste interessante Teil unserer Startup-Datei betrifft `PATH`.

Hast du dich schon einmal gefragt, woher die Shell weiß, wo sie einen Befehl finden soll?

Wenn wir beispielsweise

```bash
ls
```

eingeben, durchsucht die Shell nicht den gesamten Rechner nach einem Programm namens `ls`.

Stattdessen verwendet sie eine Liste von Verzeichnissen, die in der Variable

```text
PATH
```

gespeichert ist.

Wir können sie anzeigen mit:

```bash
echo $PATH
```

Die Ausgabe könnte beispielsweise so aussehen:

```text
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin
```

Die einzelnen Verzeichnisse werden durch Doppelpunkte getrennt.

Wenn wir

```bash
ls
```

eingeben, sucht die Shell diese Verzeichnisse der Reihe nach nach einem passenden ausführbaren Programm ab.

:::note
## Die Reihenfolge in `PATH` ist wichtig

Die Shell verwendet normalerweise den **ersten passenden Befehl**, den sie in `PATH` findet.

Wenn beispielsweise zwei verschiedene Programme denselben Namen besitzen, entscheidet die Reihenfolge der Verzeichnisse in `PATH`, welches davon gestartet wird.

Mit

```bash
type -a ls
```

kannst du dir anzeigen lassen, wie Bash einen Namen auflöst und welche gleichnamigen Befehle sie kennt.
:::

---

## Ein Verzeichnis zu `PATH` hinzufügen

Eine Startup-Datei könnte beispielsweise folgende Zeile enthalten:

```bash
PATH=$PATH:$HOME/bin
```

Damit wird

```text
$HOME/bin
```

an den bestehenden Inhalt von `PATH` angehängt.

Das ist ein weiteres Beispiel für die Parameter Expansion, die wir in Kapitel 7 kennengelernt haben.

Sehen wir uns das Prinzip mit einer einfachen Variable an:

```bash
foo="Das ist ein "
```

Nun:

```bash
echo "$foo"
```

Ausgabe:

```text
Das ist ein
```

Jetzt erweitern wir die Variable:

```bash
foo="${foo}Text."
```

und prüfen erneut:

```bash
echo "$foo"
```

Ausgabe:

```text
Das ist ein Text.
```

Auf diese Weise können wir vorhandene Variablenwerte erweitern.

Bei

```bash
PATH=$PATH:$HOME/bin
```

wird also der bisherige Inhalt von `PATH` genommen und um

```text
:$HOME/bin
```

ergänzt.

Dadurch gehört unser persönliches Verzeichnis

```text
~/bin
```

anschließend zu den Verzeichnissen, in denen die Shell nach Befehlen sucht.

Wir können dort also eigene Programme oder Skripte ablegen und sie anschließend über ihren Namen starten.

:::note
## Heute ist auch `~/.local/bin` üblich

Neben

```text
~/bin
```

wird auf modernen Linux-Systemen häufig auch

```text
~/.local/bin
```

für benutzerspezifische Programme verwendet.

Viele Distributionen und Werkzeuge berücksichtigen dieses Verzeichnis automatisch oder fügen es bei Bedarf zu `PATH` hinzu.

Prüfe deshalb zunächst deinen aktuellen `PATH`:

```bash
echo "$PATH"
```

bevor du ihn manuell veränderst.
:::

:::note
## Variablen besser in Anführungszeichen setzen

In vielen älteren Shell-Beispielen sehen wir:

```bash
echo $foo
```

Für einfache Demonstrationen funktioniert das häufig.

In echten Shell-Skripten ist jedoch normalerweise die sicherere Schreibweise:

```bash
echo "$foo"
```

Durch die Anführungszeichen vermeiden wir unerwünschtes **Word Splitting** und **Pathname Expansion**.

Bei Zuweisungen wie

```bash
PATH=$PATH:$HOME/bin
```

gelten besondere Shell-Regeln, weshalb dort keine Wortaufteilung wie bei normalen Befehlsargumenten stattfindet. Trotzdem ist eine klar strukturierte Schreibweise häufig leichter zu lesen.
:::

Viele Distributionen konfigurieren solche Verzeichnisse bereits automatisch.

Debian-basierte Systeme prüfen beispielsweise häufig beim Login, ob bestimmte persönliche `bin`-Verzeichnisse existieren, und ergänzen `PATH` entsprechend.

Bevor wir also Änderungen vornehmen, lohnt sich immer ein Blick in die vorhandenen Startup-Dateien.

---

# `export`

Am Ende unseres Beispiels steht:

```bash
export PATH
```

Der Befehl `export` sorgt dafür, dass `PATH` Teil der Umgebung von anschließend gestarteten Kindprozessen wird.

Vereinfacht gesagt wird aus einer normalen Shell-Variable damit eine **exportierte Variable**, die an Kindprozesse weitergegeben wird.

Wir können Zuweisung und Export auch in einer Zeile kombinieren:

```bash
export EDITOR=nano
```

Das setzt `EDITOR` auf `nano` und exportiert die Variable gleichzeitig.

---

# Wie Kindprozesse ihre Umgebung erben

Dieser Punkt ist wichtig genug, um ihn praktisch auszuprobieren.

Shell-Variablen sind zunächst lokal zur aktuellen Shell und werden nicht automatisch an Kindprozesse weitergegeben.

Beginnen wir mit einer normalen Shell-Variable:

```bash
foo="bar"
```

Nun starten wir eine weitere Bash:

```bash
bash
```

Auf den ersten Blick scheint nichts passiert zu sein.

Tatsächlich läuft jetzt jedoch eine **zweite Bash-Instanz** innerhalb der ersten.

Mit

```bash
ps
```

können wir das überprüfen:

```text
    PID TTY          TIME CMD
1011638 pts/9    00:00:00 bash
1011650 pts/9    00:00:00 bash
1011662 pts/9    00:00:00 ps
```

Wir sehen zwei Bash-Prozesse.

Da wir die zweite Bash nicht im Hintergrund gestartet haben, läuft sie jetzt im Vordergrund. Die ursprüngliche Shell wartet darauf, dass die neue Shell beendet wird.

Versuchen wir nun, unsere Variable anzuzeigen:

```bash
echo "$foo"
```

Wir erhalten keine Ausgabe.

Warum?

Weil `foo` nur eine **Shell-Variable** der ursprünglichen Bash war.

Die neu gestartete Bash hat diese Variable nicht geerbt.

Beenden wir die zweite Bash wieder:

```bash
exit
```

Nun befinden wir uns wieder in der ursprünglichen Shell.

Prüfen wir:

```bash
echo "$foo"
```

Ausgabe:

```text
bar
```

Die Variable ist dort weiterhin vorhanden.

---

## Eine Variable exportieren

Probieren wir dasselbe nun mit einer exportierten Variable.

Zuerst:

```bash
export foo="bar"
```

Dann starten wir erneut eine Kind-Shell:

```bash
bash
```

Nun:

```bash
echo "$foo"
```

Ausgabe:

```text
bar
```

Diesmal hat die Kind-Shell die Variable geerbt.

:::note
## Vererbung geht nur in eine Richtung

Ein Kindprozess erhält beim Start eine Umgebung, die auf der Umgebung seines Elternprozesses basiert.

Änderungen des Kindes fließen jedoch **nicht zurück** zum Elternprozess.

Wenn wir also in der Kind-Shell schreiben:

```bash
foo="barbar"
```

und anschließend mit

```bash
exit
```

zur Eltern-Shell zurückkehren, enthält deren `foo` weiterhin:

```text
bar
```

Ein Kindprozess kann die Umgebung seines Elternprozesses nicht nachträglich verändern.

Diese Regel wird später beim Schreiben von Shell-Skripten sehr wichtig.
:::

---

# Ein Programm mit temporärer Umgebung starten

Die Shell bietet noch einen praktischen Trick.

Wir können einem einzelnen Befehl eine Umgebungsvariable mitgeben, ohne sie dauerhaft in unserer aktuellen Shell zu verändern.

Die Syntax lautet:

```bash
VARIABLE=Wert befehl
```

Ein Beispiel ist `man`.

`man` beziehungsweise die darunter verwendeten Werkzeuge können die Variable `MANWIDTH` berücksichtigen, um die gewünschte Breite der formatierten Ausgabe festzulegen.

Zum Beispiel:

```bash
MANWIDTH=75 man ls
```

Damit starten wir `man ls` mit

```text
MANWIDTH=75
```

in seiner Umgebung.

Diese Einstellung gilt nur für diesen Befehl und die daraus entstehenden Kindprozesse.

Danach ist unsere ursprüngliche Shell unverändert.

Wir können das Prinzip mit einem einfacheren Beispiel demonstrieren:

```bash
LANG=C date
```

Hier erhält nur dieser Aufruf von `date` die Locale-Einstellung `C`.

:::note
## Temporäre Umgebungsvariablen sind äußerst praktisch

Die Schreibweise

```bash
VARIABLE=Wert befehl
```

ist besonders nützlich zum Testen.

Statt eine Konfigurationsdatei zu verändern, können wir ausprobieren, wie ein einzelnes Programm mit einer bestimmten Einstellung reagiert.

Für komplexere Fälle gibt es außerdem den Befehl:

```bash
env
```

Mit

```bash
man env
```

erfährst du mehr darüber.
:::

Wir könnten für `man` auch einen Alias definieren:

```bash
alias man='MANWIDTH=75 man'
```

Dann wird bei jedem Aufruf über diesen Alias die Ausgabe entsprechend formatiert.

Beachte dabei die geraden ASCII-Anführungszeichen `'`.

Typografische Zeichen wie

```text
‘ ’
```

sehen zwar hübsch aus, besitzen in der Shell aber **nicht dieselbe Bedeutung**.

---

# Die Umgebung verändern

Jetzt wissen wir,

- woher unsere Shell-Konfiguration kommt,
- welche Startup-Dateien Bash verwendet,
- und wie Variablen funktionieren.

Damit können wir beginnen, unsere Umgebung an unsere eigenen Bedürfnisse anzupassen.

---

# Welche Dateien sollten wir verändern?

Als grobe Faustregel gilt:

Einstellungen, die die Umgebung einer Login-Sitzung betreffen – beispielsweise bestimmte Umgebungsvariablen oder Ergänzungen von `PATH` – gehören je nach Distribution häufig in:

```text
~/.profile
```

oder:

```text
~/.bash_profile
```

Bash-spezifische Einstellungen für interaktive Shells gehören dagegen normalerweise in:

```text
~/.bashrc
```

Dazu zählen beispielsweise:

- Aliase,
- Prompt-Einstellungen,
- Shell-Optionen,
- interaktive Funktionen.

:::note
## Die genaue Datei hängt vom System ab

Die klassische Aufteilung zwischen `~/.profile`, `~/.bash_profile` und `~/.bashrc` ist weiterhin wichtig, aber moderne Desktop-Umgebungen können Umgebungsvariablen zusätzlich über andere Mechanismen verwalten.

Bevor du deine Konfiguration änderst, solltest du deshalb prüfen, welche Startup-Dateien deine Distribution bereits eingerichtet hat und wie diese miteinander verknüpft sind.

Für unsere Bash-Übungen bleibt `~/.bashrc` die wichtigste Datei für die interaktive Shell.
:::

Sofern du nicht als Systemadministrator bewusst Einstellungen für **alle Benutzer** ändern möchtest, solltest du deine Änderungen zunächst auf Dateien in deinem eigenen Home-Verzeichnis beschränken.

Natürlich können auch globale Dateien unter `/etc` verändert werden.

Eine fehlerhafte Änderung dort betrifft jedoch möglicherweise alle Benutzer des Systems.

Für unsere Übungen bleiben wir deshalb bei den persönlichen Konfigurationsdateien.

---

# Texteditoren

Um die Startup-Dateien der Shell – und überhaupt die meisten Konfigurationsdateien unter Linux – zu bearbeiten, benötigen wir einen **Texteditor**.

Ein Texteditor ähnelt auf den ersten Blick einer Textverarbeitung: Wir können Text eingeben, löschen und verändern.

Es gibt jedoch einen entscheidenden Unterschied.

Texteditoren arbeiten mit **reinem Text**.

Sie speichern keine Dokumentformatierungen wie Schriftarten, Seitenlayouts oder eingebettete Formatierungsinformationen, wie es klassische Textverarbeitungen tun.

Das macht Texteditoren zu einem der wichtigsten Werkzeuge für

- Softwareentwickler,
- Systemadministratoren,
- Shell-Benutzer,
- und eigentlich jeden, der Linux ernsthaft konfigurieren möchte.

Linux bietet eine erstaunlich große Auswahl an Texteditoren.

Warum so viele?

Nun, Programmierer benutzen Texteditoren ständig.

Und Programmierer schreiben gerne Programme.

Es war also wohl unvermeidlich, dass viele von ihnen irgendwann beschlossen haben, ihren eigenen perfekten Editor zu bauen.

---

# Grafische und terminalbasierte Editoren

Texteditoren lassen sich grob in zwei Kategorien einteilen:

- grafische Editoren,
- terminalbasierte Editoren.

Unter GNOME gibt es beispielsweise den modernen **GNOME Text Editor**. Auf manchen Systemen ist weiterhin `gedit` vorhanden.

KDE bietet unter anderem

- `KWrite`
- und den leistungsfähigeren `Kate`.

Im Terminal begegnen uns besonders häufig:

- `nano`
- `vi`
- `vim`
- `emacs`

`nano` ist ein vergleichsweise einfacher und leicht zugänglicher Editor. Er wurde ursprünglich als freier Ersatz für den Editor `pico` entwickelt, der zur E-Mail-Software PINE gehörte.

`vi` ist der klassische Unix-Texteditor.

Auf vielen Linux-Systemen verwenden wir heute stattdessen `vim`:

**Vi IMproved**

Mit `vi` beziehungsweise `vim` werden wir uns im nächsten Kapitel ausführlicher beschäftigen.

`emacs` wurde ursprünglich von Richard Stallman entwickelt und ist weit mehr als nur ein einfacher Texteditor. Im Laufe der Zeit entwickelte er sich zu einer enorm leistungsfähigen, erweiterbaren Arbeitsumgebung.

Er ist auf praktisch allen Distributionen verfügbar, wird aber nicht unbedingt standardmäßig installiert.

:::note
## Noch mehr Editoren

Die Welt der Linux-Editoren ist inzwischen noch größer.

Neben den klassischen Programmen begegnen uns heute beispielsweise auch:

- `micro`
- `Neovim`
- Visual Studio Code
- Zed
- Helix

Für dieses Buch sind vor allem die klassischen Terminaleditoren interessant, weil sie auch auf minimalistischen oder entfernten Linux-Systemen verfügbar sein können.

Insbesondere grundlegende `vi`-Kenntnisse sind deshalb weiterhin nützlich.
:::

---

# Einen Texteditor verwenden

Texteditoren werden auf der Kommandozeile normalerweise gestartet, indem wir zunächst den Namen des Editors und anschließend die zu bearbeitende Datei angeben.

Zum Beispiel:

```bash
gedit some_file
```

Wenn `some_file` bereits existiert, wird sie geöffnet.

Existiert sie nicht, geht der Editor normalerweise davon aus, dass wir eine neue Datei mit diesem Namen erstellen möchten.

Grafische Texteditoren sind weitgehend selbsterklärend.

Wir konzentrieren uns deshalb zunächst auf einen terminalbasierten Editor:

```text
nano
```

Damit bearbeiten wir unsere `~/.bashrc`.

Doch bevor wir das tun, üben wir eine wichtige Gewohnheit.

---

# Erst ein Backup erstellen

Wenn wir eine wichtige Konfigurationsdatei verändern, sollten wir vorher eine Sicherungskopie erstellen.

Für `~/.bashrc` können wir das so tun:

```bash
cp ~/.bashrc ~/.bashrc.bak
```

Der Name der Sicherungskopie ist nicht vorgeschrieben.

Typische Endungen sind beispielsweise:

```text
.bak
.sav
.old
.orig
```

Wichtig ist nur, dass wir später noch wissen, was die Datei bedeutet.

:::note
## Vorsicht: `cp` kann Dateien überschreiben

Wenn

```text
~/.bashrc.bak
```

bereits existiert, kann ein normaler `cp`-Aufruf diese Datei überschreiben.

Wenn du das vermeiden möchtest, kannst du beispielsweise den interaktiven Modus verwenden:

```bash
cp -i ~/.bashrc ~/.bashrc.bak
```

Dann fragt `cp` vor dem Überschreiben nach.
:::

---

# `nano` starten

Nachdem wir unser Backup erstellt haben, öffnen wir die Datei:

```bash
nano ~/.bashrc
```

Eine moderne Version von `nano` zeigt ungefähr Folgendes:

```text
GNU nano

# .bashrc

...

^G Help      ^O Write Out
^X Exit      ^W Where Is
```

Oben sehen wir Informationen zum Editor beziehungsweise zur geöffneten Datei.

In der Mitte befindet sich der eigentliche Text.

Am unteren Rand zeigt `nano` wichtige Tastaturbefehle an.

---

## Die `^`-Notation

Eine der ersten etwas ungewöhnlichen Darstellungen ist beispielsweise:

```text
^X
```

Das bedeutet:

```text
Ctrl-x
```

Das Zeichen

```text
^
```

wird traditionell verwendet, um die `Ctrl`-Taste darzustellen.

Um `nano` zu verlassen, drücken wir also:

```text
Ctrl-x
```

Diese Schreibweise für Steuerzeichen begegnet uns auch in vielen anderen Unix-Programmen.

---

## Speichern

Der zweite Befehl, den wir unbedingt kennen müssen, ist das Speichern.

In `nano` verwenden wir:

```text
Ctrl-o
```

`nano` nennt diese Funktion **Write Out**.

Nach `Ctrl-o` fragt `nano` nach dem Dateinamen.

Da wir die vorhandene Datei bearbeiten, können wir den vorgeschlagenen Namen normalerweise einfach mit `Enter` bestätigen.

Mit diesen beiden Tastenkombinationen können wir bereits arbeiten:

```text
Ctrl-o    speichern
Ctrl-x    beenden
```

---

# Unsere `.bashrc` verändern

Bewegen wir den Cursor nun ans Ende von `~/.bashrc`.

Dort könnten wir beispielsweise folgende Einstellungen hinzufügen:

```bash
umask 0002

export HISTCONTROL=ignoredups
export HISTSIZE=1000

alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

Was bedeuten diese Zeilen?

| Zeile | Bedeutung |
| ----- | --------- |
| `umask 0002` | Setzt die `umask` so, dass neu angelegte Dateien und Verzeichnisse Gruppen-Schreibrechte nicht grundsätzlich herausfiltern. Das kann beispielsweise für gemeinsam genutzte Verzeichnisse relevant sein, wie wir sie in Kapitel 9 behandelt haben. |
| `export HISTCONTROL=ignoredups` | Verhindert, dass ein Befehl direkt mehrfach hintereinander in der Bash-History gespeichert wird. |
| `export HISTSIZE=1000` | Legt fest, wie viele Befehle Bash in der aktuellen History-Liste im Speicher hält. |
| `alias l.='ls -d .* --color=auto'` | Erstellt den Alias `l.`, der Einträge anzeigt, deren Namen mit einem Punkt beginnen. |
| `alias ll='ls -l --color=auto'` | Erstellt den Alias `ll` für eine ausführliche Verzeichnisanzeige. |

:::note
## `HISTSIZE=1000` ist heute eher klein

Ältere Bash-Konfigurationen verwendeten häufig deutlich kleinere History-Werte.

Auf modernen Distributionen ist `1000` keineswegs ungewöhnlich und teilweise sogar kleiner als die vorhandene Standardeinstellung.

Bevor du den Wert übernimmst, prüfe deshalb:

```bash
echo "$HISTSIZE"
```

Zusätzlich existiert:

```bash
HISTFILESIZE
```

Diese Variable bestimmt, wie viele Zeilen Bash in der History-Datei speichern darf.

Du kannst beide Werte unabhängig voneinander konfigurieren.
:::

:::note
## `umask 0002` nicht blind übernehmen

Die passende `umask` hängt davon ab, wie dein System verwendet wird.

`0002` ist praktisch, wenn Benutzer innerhalb einer gemeinsamen Gruppe Dateien miteinander bearbeiten sollen.

Auf einem persönlichen Desktop ist häufig auch

```text
0022
```

anzutreffen.

Ändere deine `umask` daher bewusst und nicht nur deshalb, weil sie in einem Beispiel vorkommt.
:::

Möglicherweise enthält deine Distribution einige dieser Einstellungen bereits.

Bevor du neue Aliase oder Variablen hinzufügst, lohnt es sich deshalb, die vorhandene `~/.bashrc` zu lesen.

---

# Kommentare hinzufügen

Unsere neuen Einstellungen funktionieren zwar, aber einige davon sind nicht gerade selbsterklärend.

Deshalb sollten wir Kommentare hinzufügen.

Zum Beispiel:

```bash
# Change umask to make directory sharing easier
umask 0002

# Ignore consecutive duplicates in command history
# and keep 1000 entries in the in-memory history
export HISTCONTROL=ignoredups
export HISTSIZE=1000

# Add some helpful aliases
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

Natürlich können wir die Kommentare in unserer eigenen Konfiguration auch auf Deutsch schreiben:

```bash
# umask für gemeinsam bearbeitete Dateien
umask 0002

# Doppelte aufeinanderfolgende History-Einträge ignorieren
# und 1000 Einträge im Speicher behalten
export HISTCONTROL=ignoredups
export HISTSIZE=1000

# Nützliche Aliase
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

Das sieht schon deutlich besser aus.

Wenn wir fertig sind, speichern wir mit:

```text
Ctrl-o
```

und verlassen `nano` mit:

```text
Ctrl-x
```

---

# Warum Kommentare wichtig sind

Wenn du Konfigurationsdateien veränderst, solltest du deine Änderungen dokumentieren.

Heute weißt du vermutlich noch genau, warum du eine bestimmte Zeile hinzugefügt hast.

Morgen wahrscheinlich auch.

Aber wie sieht es in sechs Monaten aus?

Oder in drei Jahren?

Tu deinem zukünftigen Ich einen Gefallen und schreibe Kommentare.

Bei größeren Änderungen kann es außerdem sinnvoll sein, ein Protokoll darüber zu führen, was verändert wurde.

Und wenn du Konfigurationsdateien ohnehin mit Git verwaltest, bekommst du zusätzlich eine ausgezeichnete Änderungshistorie.

:::note
## Git für Konfigurationsdateien

Viele erfahrene Linux-Benutzer verwalten ihre persönlichen Konfigurationsdateien – oft **Dotfiles** genannt – mit Git.

Dazu gehören beispielsweise:

```text
.bashrc
.gitconfig
.config/
```

Das hat einen großen Vorteil:

Änderungen lassen sich nachvollziehen und bei Bedarf wieder rückgängig machen.

Allerdings gehören **Passwörter, API-Schlüssel, Tokens und andere Geheimnisse niemals versehentlich in ein öffentliches Git-Repository**.
:::

---

# Kommentare in Shell-Dateien

Shell-Skripte und Bash-Startup-Dateien verwenden das Zeichen

```text
#
```

für Kommentare.

Zum Beispiel:

```bash
# Das ist ein Kommentar
alias ll='ls -l'
```

Andere Konfigurationsformate können andere Regeln für Kommentare verwenden.

Normalerweise enthalten vorhandene Konfigurationsdateien bereits Beispiele, an denen wir uns orientieren können.

Häufig finden wir außerdem Konfigurationszeilen, die **auskommentiert** wurden.

Zum Beispiel könnte eine `~/.bashrc` Folgendes enthalten:

```bash
# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
```

Die letzten drei Zeilen enthalten gültige Alias-Definitionen, sind jedoch deaktiviert, weil am Anfang jeweils ein `#` steht.

Entfernen wir das führende `#`, wird die entsprechende Konfiguration aktiviert.

Dieser Vorgang wird häufig als **Auskommentierung entfernen** beziehungsweise englisch **uncommenting** bezeichnet.

Umgekehrt können wir eine vorhandene Konfigurationszeile deaktivieren, indem wir ein `#` davorsetzen:

```bash
# alias ll='ls -alF'
```

Das ist oft besser, als eine Zeile sofort zu löschen.

So bleibt die ursprüngliche Einstellung sichtbar und kann leicht wieder aktiviert werden.

:::note
## Leerzeichen nach `#`

Beide Varianten sind für Bash gültig:

```bash
#Kommentar
```

und:

```bash
# Kommentar
```

Für menschliche Leser ist die zweite Form normalerweise angenehmer:

```bash
# Kommentar
```
:::

---

# Unsere Änderungen aktivieren

Die Änderungen an `~/.bashrc` wirken sich nicht rückwirkend auf eine bereits laufende Shell aus.

Die Datei wird beim Start einer passenden interaktiven Bash eingelesen.

Eine Möglichkeit besteht daher darin, das Terminal zu schließen und ein neues zu öffnen.

Es geht aber einfacher.

Wir können Bash anweisen, die geänderte Datei direkt in der aktuellen Shell einzulesen:

```bash
source ~/.bashrc
```

Anschließend sollten unsere neuen Einstellungen unmittelbar verfügbar sein.

Probieren wir beispielsweise einen Alias aus:

```bash
ll
```

Wenn alles funktioniert, sehen wir die entsprechende ausführliche Verzeichnisanzeige.

---

# Noch etwas mehr über `source`

`source` ist ein Bash-Builtin.

Der Befehl liest eine Datei und führt deren Befehle **in der aktuellen Shell** aus.

Wir können also schreiben:

```bash
source ~/.bashrc
```

oder in der kürzeren, traditionellen Form:

```bash
. ~/.bashrc
```

Beide Befehle bewirken hier dasselbe.

Das ist ein wichtiger Unterschied zum direkten Ausführen eines Shell-Skripts.

Angenommen, wir hätten eine Datei:

```text
settings.sh
```

mit folgendem Inhalt:

```bash
foo="bar"
```

Wenn wir diese Datei in einer separaten Bash ausführen, kann die dabei erzeugte Kind-Shell die Variable ihrer Eltern-Shell nicht verändern.

Lesen wir sie dagegen mit

```bash
source settings.sh
```

ein, wird die Zuweisung direkt in unserer **aktuellen Shell** ausgeführt.

Danach funktioniert:

```bash
echo "$foo"
```

und wir erhalten:

```text
bar
```

:::note
## Jetzt ergibt `source` wirklich Sinn

Weiter oben haben wir gesehen:

**Ein Kindprozess kann die Umgebung seines Elternprozesses nicht verändern.**

Genau deshalb verwenden wir `source`, wenn eine Datei unsere aktuelle Shell verändern soll.

`source` startet dafür keine separate Shell, sondern führt die Befehle direkt in der bereits laufenden Shell aus.

Das ist der Grund, warum

```bash
source ~/.bashrc
```

unsere aktuelle Sitzung unmittelbar verändert.
:::

All die merkwürdig aussehenden Zeilen in den Shell-Startup-Dateien sind also keine besondere Konfigurationssprache.

Es sind ganz normale Befehle und Sprachkonstrukte, die Bash versteht.

Das unterscheidet Unix-Shells deutlich von vielen einfachen Kommandointerpretern früherer Betriebssysteme.

Shells können Programme starten – aber sie sind gleichzeitig auch mächtige programmierbare Umgebungen.

Und genau diese Fähigkeit werden wir später beim Shell-Scripting intensiv nutzen.

---

# Zusammenfassung

In diesem Kapitel haben wir einen wichtigen Schritt gemacht: Wir haben gelernt, wie unsere Shell-Umgebung aufgebaut ist und wie wir sie verändern können.

Wir haben gesehen,

- was Shell- und Umgebungsvariablen sind,
- wie wir mit `printenv`, `set` und `echo` ihre Werte untersuchen,
- welche Rolle Variablen wie `HOME`, `PATH`, `LANG`, `EDITOR` und `PS1` spielen,
- wie Bash ihre Startup-Dateien auswählt,
- was Login- und Non-Login-Shells unterscheidet,
- warum `~/.bashrc` für interaktive Bash-Sitzungen so wichtig ist,
- wie `PATH` die Suche nach Programmen steuert,
- wie `export` Variablen an Kindprozesse weitergibt,
- warum Kindprozesse die Umgebung ihrer Eltern nicht verändern können,
- wie wir einem einzelnen Programm temporäre Umgebungsvariablen mitgeben,
- wie wir Konfigurationsdateien mit einem Texteditor bearbeiten,
- warum Backups und Kommentare wichtig sind,
- und wie wir Änderungen mit `source` unmittelbar in der aktuellen Shell aktivieren.

Von nun an lohnt es sich, beim Lesen von Manpages auch auf unterstützte Umgebungsvariablen zu achten.

Viele Programme lassen sich damit auf überraschend einfache Weise anpassen.

Später werden wir außerdem **Shell-Funktionen** kennenlernen. Sie können ebenfalls in Bash-Startup-Dateien definiert werden und erweitern unsere Möglichkeiten weit über einfache Aliase hinaus.

:::note
## Die wichtigsten Befehle dieses Kapitels

Für den Alltag solltest du dir zunächst besonders diese Befehle merken:

```bash
printenv
set
export
alias
source
```

Ein paar typische Beispiele:

```bash
printenv HOME
echo "$PATH"
export EDITOR=nano
alias ll='ls -l'
source ~/.bashrc
```

Und vor allem diesen Zusammenhang:

```bash
foo="bar"
```

erstellt zunächst eine Shell-Variable.

```bash
export foo
```

macht sie für anschließend gestartete Kindprozesse verfügbar.

Ein Kindprozess kann seine eigene Kopie verändern – aber nicht die Variable seines Elternprozesses.

Dieses Prinzip ist fundamental für das Verständnis von Unix-Prozessen, Shell-Skripten und der gesamten Linux-Umgebung.
:::

---

# Weiterführende Informationen

Die Bash-Manpage beschreibt die Startup-Dateien und das Startverhalten von Bash ausführlich.

Besonders interessant ist der Abschnitt:

```text
INVOCATION
```

Du kannst die Bash-Manpage öffnen mit:

```bash
man bash
```

und innerhalb von `less` nach dem Abschnitt suchen:

```text
/INVOCATION
```

Wie so oft bei Bash ist die Dokumentation umfangreich – aber gerade bei Fragen darüber, **welche Konfigurationsdatei wann gelesen wird**, ist sie die maßgebliche Referenz.