# Einleitung

Ich möchte dir eine Geschichte erzählen.

Nein, nicht die Geschichte darüber, wie Linus Torvalds 1991 den ersten Linux-Kernel geschrieben hat. Die findest du in so ziemlich jedem Linux-Buch. Und auch nicht die Geschichte darüber, wie Richard Stallman einige Jahre zuvor das GNU-Projekt ins Leben rief, um ein freies Unix-ähnliches Betriebssystem zu entwickeln. Auch das ist eine spannende Geschichte – und ebenfalls schon oft erzählt worden.

Nein. Ich möchte dir die Geschichte erzählen, wie du dir die Kontrolle über deinen Computer zurückholst.

Als ich Ende der 1970er-Jahre als Student anfing, mit Computern zu arbeiten, steckte die Computerwelt mitten in einer Revolution. Der Mikroprozessor machte es plötzlich möglich, dass ganz normale Menschen wie du und ich einen eigenen Computer besitzen konnten. Heute klingt das selbstverständlich. Damals war es alles andere als das. Computer gehörten großen Unternehmen und Behörden. Normale Menschen hatten mit ihnen kaum etwas zu tun. Und wenn doch, dann nur zu den Bedingungen derjenigen, denen die Rechner gehörten.

Heute ist alles anders. Computer sind überall. In unserer Armbanduhr. Im Smartphone. Im Auto. In riesigen Rechenzentren. Eigentlich überall, wo man hinsieht. Und fast alle diese Geräte sind miteinander vernetzt. Das hat uns eine Zeit beschert, in der jeder ungeahnte Möglichkeiten hat. Man kann lernen, entwickeln, kommunizieren und Dinge erschaffen, von denen früher kaum jemand zu träumen wagte. Doch gleichzeitig ist etwas anderes passiert. Ein paar wenige Großkonzerne haben begonnen, die Kontrolle über einen Großteil der Computer dieser Welt an sich zu ziehen. Sie entscheiden immer häufiger, was dein Computer darf – und was nicht. Zum Glück gibt es Menschen, die das nicht einfach hinnehmen. Überall auf der Welt entwickeln sie ihre eigene Software. Sie schreiben Programme, die jeder benutzen, untersuchen und verbessern darf. Sie entwickeln Linux.

Viele sprechen bei Linux von _Freiheit_. Ich glaube allerdings, dass die wenigsten wirklich meinen, was dieses Wort eigentlich bedeutet. Freiheit bedeutet nicht, dass Linux kostenlos ist. Freiheit bedeutet, selbst entscheiden zu können, was dein Computer tut. Und das kannst du nur, wenn du verstehst, was dein Computer überhaupt macht. Ein freier Computer ist ein Computer ohne Geheimnisse. Einer, dessen Funktionsweise du vollständig nachvollziehen kannst – wenn du neugierig genug bist, sie zu entdecken.

## Warum die Kommandozeile?

Ist dir schon einmal aufgefallen, dass in Filmen der „Superhacker“ – du weißt schon, der Typ, der in weniger als 30 Sekunden in den streng gesicherten Militärcomputer einbricht – sich vor den Rechner setzt und die Maus nicht einmal anfasst? Das liegt daran, dass selbst Filmemacher wissen: Wir Menschen spüren instinktiv, dass man einen Computer am besten mit der Tastatur bedient, wenn man wirklich etwas erreichen will.

Die meisten Computerbenutzer kennen heute allerdings nur noch grafische Benutzeroberflächen (GUI). Hersteller und selbsternannte Experten haben ihnen über Jahre eingeredet, die Kommandozeile (CLI) sei ein furchteinflößendes Relikt aus längst vergangenen Zeiten. Das ist schade. Denn eine gute Kommandozeile ist eine erstaunlich ausdrucksstarke Möglichkeit, mit einem Computer zu kommunizieren – fast so, wie geschriebene Sprache für uns Menschen. Man sagt nicht ohne Grund: > **Grafische Benutzeroberflächen machen einfache Aufgaben einfach. Kommandozeilen machen schwierige Aufgaben überhaupt erst möglich.** Und dieser Satz ist heute genauso wahr wie damals.

Da Linux dem Unix-Betriebssystem nachempfunden ist, hat es auch dessen reiches Erbe an Kommandozeilenwerkzeugen übernommen. Unix wurde Anfang der 1980er-Jahre populär (auch wenn seine Entwicklung bereits ein Jahrzehnt früher begann). Damals steckten grafische Benutzeroberflächen noch in den Kinderschuhen. Deshalb entwickelte sich stattdessen eine mächtige und vielseitige Kommandozeile. Genau das ist bis heute eine ihrer größten Stärken. Einer DER Gründe, warum sich viele der ersten Linux-Anwender damals für Linux und nicht etwa für Windows NT entschieden, war eben diese leistungsfähige Kommandozeile – eine Kommandozeile, mit der plötzlich scheinbar unmögliche Aufgaben möglich wurden.

## Worum es in diesem Buch geht

Dieses Buch gibt dir einen umfassenden Einstieg in das Arbeiten mit der Linux-Kommandozeile. Anders als viele andere Bücher, die sich ausschließlich mit einem einzelnen Programm beschäftigen – etwa der Shell `bash` –, geht es hier um das große Ganze: Wie arbeitet man sinnvoll mit der Kommandozeile? Wie funktioniert sie eigentlich? Was kann sie leisten? Und wie nutzt man sie am besten?

Dieses Buch ist **kein** Handbuch zur Linux-Systemadministration. Zwar führt jede ernsthafte Beschäftigung mit der Kommandozeile früher oder später zu Themen aus der Systemadministration, doch dieses Buch streift sie nur am Rande. Stattdessen legt es ein solides Fundament für alles, was danach kommt. Du lernst den sicheren Umgang mit der Kommandozeile – einem unverzichtbaren Werkzeug für praktisch jede Aufgabe in der Linux-Systemadministration.

Der Schwerpunkt dieses Buches liegt ganz klar auf Linux. Viele andere Bücher versuchen, ein möglichst breites Publikum anzusprechen, indem sie auch allgemeines Unix oder macOS behandeln. Dadurch bleiben sie oft recht oberflächlich und konzentrieren sich auf Themen, die überall gleichermaßen funktionieren.

Dieses Buch geht bewusst einen anderen Weg. Es behandelt ausschließlich moderne Linux-Distributionen. Rund 95 % des Inhalts lassen sich zwar auch auf andere Unix-ähnliche Betriebssysteme übertragen, doch dieses Buch richtet sich in erster Linie an Menschen, die die heutige Linux-Kommandozeile kennenlernen und verstehen möchten.

## Für wen dieses Buch gedacht ist

Dieses Buch richtet sich an Menschen, die neu bei Linux sind und von einer anderen Plattform wechseln. Wahrscheinlich kennst du dich bereits gut mit einer Version von Microsoft Windows aus. Vielleicht hat dir dein Chef die Administration eines Linux-Servers übertragen. Oder du steigst gerade in die spannende Welt der Single-Board-Computer ein – zum Beispiel mit einem Raspberry Pi. Vielleicht nutzt du deinen Computer einfach nur zu Hause, hast genug von den ständigen Sicherheitsproblemen und möchtest Linux endlich selbst ausprobieren.

Ganz gleich, warum du hier bist – willkommen. Dieses Buch ist für dich. Allerdings gibt es keine Abkürzung zur Linux-Erleuchtung. Die Kommandozeile zu lernen ist anspruchsvoll und erfordert echte Ausdauer. Nicht, weil sie besonders schwierig wäre – sondern weil sie unglaublich umfangreich ist. Auf einem durchschnittlichen Linux-System stehen dir buchstäblich Tausende Programme zur Verfügung, die du über die Kommandozeile nutzen kannst. Betrachte das ruhig als kleine Warnung: Die Kommandozeile lernt man nicht mal eben nebenbei.

Die gute Nachricht: Der Aufwand lohnt sich. Wenn du glaubst, heute schon ein „Power User“ zu sein, dann warte erst einmal ab. Was echte Kontrolle und echte Möglichkeiten bedeuten, wirst du erst noch entdecken. Und im Gegensatz zu vielen anderen Computerkenntnissen bleibt dieses Wissen lange wertvoll. Was du heute über die Kommandozeile lernst, wirst du wahrscheinlich auch in zehn Jahren noch nutzen können. Sie hat den Test der Zeit bestanden.

Es spielt übrigens keine Rolle, ob du schon einmal programmiert hast oder nicht. Falls nicht – keine Sorge. Ich bringe dich auch auf diesen Weg.

## Was dich in diesem Buch erwartet

Der Stoff ist in einer sorgfältig gewählten Reihenfolge aufgebaut. Stell dir vor, ein erfahrener Tutor sitzt neben dir und führt dich Schritt für Schritt durch die Welt der Kommandozeile. Viele Autoren gehen hier sehr systematisch vor und behandeln jedes Thema vollständig, bevor sie zum nächsten übergehen. Das ist aus Sicht des Autors nachvollziehbar, kann Einsteiger aber schnell überfordern.

Das Ziel dieses Buches ist es, dir die Unix-Denkweise näherzubringen. Sie unterscheidet sich in vielen Punkten von der Denkweise, die man aus der Windows-Welt kennt. Unterwegs machen wir immer wieder kleine Abstecher, um zu verstehen, warum bestimmte Dinge so funktionieren, wie sie funktionieren – und wie sie sich im Laufe der Zeit entwickelt haben. Denn Linux ist nicht einfach nur ein Betriebssystem. Es ist Teil der größeren Unix-Kultur, mit ihrer eigenen Geschichte, ihrer eigenen Sprache und ihrer eigenen Art zu denken. Und hin und wieder werde ich mir dabei auch den einen oder anderen kleinen Seitenhieb nicht verkneifen können.

Das Buch ist in vier Teile gegliedert, die jeweils einen wichtigen Bereich der Arbeit mit der Kommandozeile behandeln:

* **Teil 1 – Die Shell kennenlernen**
  Hier beginnen wir unsere Reise mit den Grundlagen der Kommandozeile. Du lernst den Aufbau von Befehlen kennen, bewegst dich sicher durch das Dateisystem, bearbeitest Befehle direkt in der Kommandozeile und erfährst, wie du Hilfe und Dokumentation zu Programmen findest.

* **Teil 2 – Konfiguration und Umgebung**
  In diesem Teil geht es um Konfigurationsdateien, mit denen sich das Verhalten deines Systems über die Kommandozeile steuern und anpassen lässt.

* **Teil 3 – Häufige Aufgaben und unverzichtbare Werkzeuge**
  Jetzt wird es praktisch. Du lernst viele alltägliche Aufgaben kennen, die sich bequem über die Kommandozeile erledigen lassen. Unix-ähnliche Betriebssysteme wie Linux bringen eine Vielzahl klassischer Kommandozeilenprogramme mit, mit denen sich Daten auf erstaunlich leistungsfähige Weise verarbeiten lassen.

* **Teil 4 – Shell-Skripte schreiben**
  Zum Schluss steigen wir in die Shell-Programmierung ein. Sie ist zwar vergleichsweise einfach aufgebaut, eignet sich aber hervorragend, um wiederkehrende Aufgaben zu automatisieren. Gleichzeitig lernst du grundlegende Programmierkonzepte kennen, die dir später auch beim Einstieg in andere Programmiersprachen helfen werden.

## Wie du dieses Buch am besten liest

Am besten beginnst du ganz vorne und arbeitest dich Kapitel für Kapitel bis zum Ende durch. Dieses Buch ist nicht als Nachschlagewerk gedacht. Es erzählt vielmehr eine Geschichte – mit einem Anfang, einem Mittelteil und einem Ende.

### Voraussetzungen

Um mit diesem Buch arbeiten zu können, brauchst du lediglich eine funktionierende Linux-Installation. Dafür gibt es zwei Möglichkeiten:

1. **Installiere Linux auf einem Computer.**
   Es spielt keine große Rolle, für welche Distribution du dich entscheidest. Viele starten heute mit Ubuntu, Fedora oder OpenSUSE. Wenn du unsicher bist, nimm einfach Ubuntu. Je nach Hardware kann die Installation einer modernen Linux-Distribution erstaunlich einfach oder überraschend knifflig sein. Empfehlenswert ist ein Desktop-PC, der ein paar Jahre alt ist und mindestens 2 GB Arbeitsspeicher sowie 6 GB freien Festplattenspeicher mitbringt. Wenn möglich, verzichte zunächst auf Laptops und WLAN. Gerade bei älterer Hardware können sie die Einrichtung unnötig erschweren.

2. **Nutze eine Live-CD oder einen bootfähigen USB-Stick.**
   Viele Linux-Distributionen lassen sich direkt von einer CD oder einem USB-Stick starten, ohne sie zu installieren. Ändere dazu in den BIOS-Einstellungen die Bootreihenfolge, sodass dein Computer von CD oder USB startet, und starte ihn anschließend neu. Das ist eine hervorragende Möglichkeit, vor einer Installation zu prüfen, ob Linux mit deiner Hardware problemlos zusammenarbeitet. Der Nachteil: Ein Live-System ist oft deutlich langsamer als eine fest installierte Linux-Version. Ubuntu und Fedora gehören unter anderem zu den Distributionen, die als Live-Version verfügbar sind.

Egal, für welche Variante du dich entscheidest: Für einige Übungen in diesem Buch benötigst du gelegentlich **Superuser-Rechte**, also Administratorrechte.

Sobald dein Linux-System läuft, kannst du direkt loslegen. Lies das Buch nicht nur – mach mit. Die meisten Kapitel sind zum Ausprobieren gedacht. Also setz dich an den Rechner und fang einfach an zu tippen!

:::note
## Warum ich es nicht „GNU/Linux“ nenne

In manchen Kreisen gilt es als politisch korrekt, das Betriebssystem als **„GNU/Linux“** zu bezeichnen. Das Problem dabei ist, dass es eigentlich gar keine vollständig richtige Bezeichnung gibt. Linux ist das Ergebnis der Arbeit unzähliger Menschen, die gemeinsam an einem riesigen, verteilten Entwicklungsprojekt mitgewirkt haben.

Streng genommen bezeichnet **Linux** lediglich den Kernel des Betriebssystems – und nichts weiter. Natürlich ist der Kernel das Herzstück des Systems. Ohne ihn läuft nichts. Aber allein macht er noch kein vollständiges Betriebssystem aus.

An dieser Stelle kommt Richard Stallman ins Spiel – ein ebenso brillanter wie kontroverser Programmierer und Vordenker der Freie-Software-Bewegung. Er gründete die Free Software Foundation, rief das GNU-Projekt ins Leben, schrieb die erste Version des GNU C Compilers (`gcc`), entwickelte die GNU General Public License (GPL) und vieles mehr.

Stallman vertritt die Ansicht, das Betriebssystem müsse **„GNU/Linux“** heißen, um den Beitrag des GNU-Projekts angemessen zu würdigen. Tatsächlich entstand das GNU-Projekt schon vor dem Linux-Kernel, und seine Leistungen verdienen ohne Frage große Anerkennung. Trotzdem wäre es meiner Meinung nach unfair, nur GNU im Namen hervorzuheben und die vielen anderen Mitwirkenden außen vor zu lassen. Außerdem wäre aus rein technischer Sicht **„Linux/GNU“** sogar treffender – schließlich startet zuerst der Kernel, und alles andere läuft anschließend darauf.

Im allgemeinen Sprachgebrauch bezeichnet **Linux** ohnehin nicht nur den Kernel, sondern das gesamte Paket aus freier und quelloffener Software, das eine typische Linux-Distribution ausmacht – kurz gesagt: das gesamte Linux-Ökosystem und nicht nur die GNU-Komponenten.

Außerdem scheint die Welt der Betriebssysteme kurze, einprägsame Namen zu bevorzugen: DOS, Windows, macOS, Solaris, IRIX oder AIX bestehen schließlich auch nur aus einem Wort. Deshalb verwende ich in diesem Buch ebenfalls die gebräuchliche Bezeichnung **Linux**.

Falls du allerdings lieber **„GNU/Linux“** sagst, dann ersetze beim Lesen dieses Buches das Wort _Linux_ einfach gedanklich durch _GNU/Linux_. Ich habe nichts dagegen.
:::

## Was ist neu in der siebten Internetausgabe?

Während die Shell selbst nur etwa alle zehn Jahre eine neue Hauptversion erhält, entwickeln sich Hardware und Werkzeuge ständig weiter. Deshalb wurde auch diese Ausgabe von _The Linux Command Line_ erneut an die heutige Kommandozeilenumgebung angepasst. Neben zahlreichen kleineren Korrekturen und Verbesserungen entspricht sie jetzt außerdem der gedruckten Ausgabe _The Linux Command Line: A Complete Introduction, Third Edition_, die bei No Starch Press erschienen ist. Eine ausführliche Übersicht aller Änderungen findest du in den Release Notes auf LinuxCommand.org. Neu in dieser Ausgabe ist außerdem eine Sammlung der Beispielskripte aus dem Buch. Auch sie kannst du auf LinuxCommand.org herunterladen.

## Danksagung

Dieses Buch wäre ohne die Unterstützung vieler Menschen nicht möglich gewesen. Ihnen allen möchte ich herzlich danken. Jenny Watson, Lektorin bei Wiley Publishing, brachte mich ursprünglich auf die Idee, ein Buch über Shell-Skripte zu schreiben. John C. Dvorak, bekannter Kolumnist und Technikkommentator, sagte einmal in einer Folge seines Videopodcasts _Cranky Geeks_:

> „Zur Hölle, schreib jeden Tag 200 Wörter, und nach einem Jahr hast du einen Roman.“

Dieser Rat brachte mich auf die Idee, jeden Tag eine Seite zu schreiben – bis schließlich ein ganzes Buch daraus geworden war.

Dmitri Popov schrieb im _Free Software Magazine_ den Artikel _Creating a Book Template with Writer_. Er inspirierte mich dazu, den Text dieses Buches mit OpenOffice.org Writer (und später LibreOffice Writer) zu verfassen. Wie sich herausstellte, war das eine ausgezeichnete Entscheidung. Mark Polesky unterzog die erste Ausgabe einer außergewöhnlich gründlichen Prüfung und testete sie ausführlich. Jesse Becker, Tomasz Chrzczonowicz, Michael Levin und Spence Miner testeten und begutachteten ebenfalls Teile der ersten Ausgabe. Karen M. Shotts investierte unzählige Stunden, um mein sogenanntes Englisch zu überarbeiten und das ursprüngliche Manuskript sprachlich zu verfeinern.

::: note
## Siebte Internetausgabe

Mein besonderer Dank gilt den folgenden Personen, deren wertvolles Feedback in die siebte Internetausgabe eingeflossen ist: Vitor Centeio, Elmar Deininger, Francesco Di Viesto, Jaroslaw Kolosowski, Kayck Matias und Wang Zheng.
:::

::: note
## Frühere Ausgaben

Mein besonderer Dank gilt außerdem allen, die mit ihrem wertvollen Feedback zu den früheren Ausgaben beigetragen haben: Ala'a Ali, Adrian Arpidez, Mikey Barboza, Jesse Becker, Emanuele Bernardi, Andreas Bjørnestad, Hu Bo, Steve Bragg, John Burns, Heriberto Cantú, Enzo Cardinal, Paolo Casati, Tomasz Chrzczonowicz, Richard Cooke, Ethan Dowlatshah, Lixin Duan, Joshua Escamilla, Marc Evans, Ryan Flynn, Bruce Fowler, Devin Harper, Jørgen Heitmann, Janrodion, Jonathan Jones, Sunil Joshi, Ma Jun, Eric Kammerer, Robert Kennington, Seth King, Chris Knight, Jaroslaw Kolosowski, Klaus M. Körmendi, Jim Kovacs, Michael Levin, Bartłomiej Majka, Bashar Maree, Frank McTipps, Vladimir Milovanović, Sea Monkey, Tim Nelson, Mike O'Donnell, Oktay-Akin Okutan, Nick Owens, Justin Page, Michael Parrish, Esra Purba, Parviz Rasoulipour, Amir Razqandi, Patrick, Waldo Ribeiro, Pat Roche, Nick Rose, Satej Kumar Sahu, Avid Seeker, Mikhail Sizov, Ben Slater, Pickles Spill, Gabriel Stutzman, Pooya Taherkhani, Francesco Turco, Wolfram Volpi, Boyang Wang, Carl Westman, John Wiersba, Valter Wierzba und Christian Wuethrich.
:::

Und nicht zuletzt danke ich den Leserinnen und Lesern von LinuxCommand.org. Ihr habt mir im Laufe der Jahre so viele freundliche E-Mails geschrieben. Eure Ermutigung hat mir gezeigt, dass ich offenbar etwas geschaffen habe, das vielen Menschen weiterhilft.

## Dein Feedback ist gefragt!

Dieses Buch ist ein fortlaufendes Projekt – ganz ähnlich wie viele Open-Source-Projekte. Wenn dir ein technischer Fehler auffällt, freue ich mich über eine kurze Nachricht an:

`bshotts@users.sourceforge.net`

Gib dabei bitte unbedingt an, welche Ausgabe des Buches du gerade liest. Vielleicht fließen deine Hinweise oder Verbesserungsvorschläge ja schon in eine der nächsten Versionen ein.

## Weiterführende Literatur

-**Wenn du mehr über die oben erwähnten Persönlichkeiten erfahren möchtest, findest du hier zwei gute Einstiege:**
- <https://en.wikipedia.org/wiki/Linus_Torvalds>
- <https://en.wikipedia.org/wiki/Richard_Stallman>

- **Die Free Software Foundation und das GNU-Projekt**
- <https://en.wikipedia.org/wiki/Free_Software_Foundation>
- <https://www.fsf.org>
- <https://www.gnu.org>

- **Richard Stallman über die Bezeichnung „GNU/Linux“**
- <https://www.gnu.org/gnu/why-gnu-linux.html>
- <https://www.gnu.org/gnu/gnu-linux-faq.html#tools>