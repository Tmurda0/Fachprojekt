=== Projektstruktur ===

Die initiale Projektstruktur umfasst die im Folgenden gelisteten Haupt-Projekte.
Vorgegebene Benennungen (z.B. für Projekte, Modelle, Dateiendungen, etc.) sollen übernommen und möglichst nicht geändert werden.

== info.scce.cinco.fp.compdsl ==

Das Xtext-Projekt, in dem die textuelle DSL für Produktkomponenten entwickelt werden soll. Die zentrale Xtext-Datei mit der zu entwickelnden Grammatik ist src/info.scce.cinco.fp.compdsl/ComponentDsl.xtext


== info.scce.cinco.fp.compgen ==

Das Plugin-Projekt mit dem bereitgestellten pseudo Datenbankservice, der Beschreibungen und Attribute von Produktkomponenten liefert. Der zentrale Service info.scce.cinco.fp.prodserv.ProductService stellt dafür statische Methoden bereit. Die zu entwickelnden Generatoren befinden sich in Form von Xtend-Dateien in src/info.scce.cinco.fp.compgen.generator . Diese sind in der Produktinstanz über Aktionen im Kontextmenü zu ".comp"-Dateien ausführbar (z.B. "Component Generator > Generate Mainboards").


== info.scce.cinco.product.fp.pcconfig ==

Das Projekt zum Cinco-Produkt mit den zu entwickelnden Modellen "Mainboard" und "PC" im Verzeichnis "model".