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
