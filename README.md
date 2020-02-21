# FS Benchmark
Vorm Laufen der Tests: ``sudo sysctl kernel.randomize_va_space=0``  
Nach dem Test: ``sudo sysctl -a --pattern kernel.randomize_va_space=2``, um ASLR wieder zu aktivieren.

## TODOS

* Mehrere Durchläufe in run pro Szenario
* Copyfiles testen
* Einmal durchlaufen lassen
* Gesamtlaufzeit abschätzen (auch pro Szenario)
* Basescripts Konfigurieren
* (done) In run.sh entfernen aller Dateien im Zielordner vor dem Ausführen des filebench befehls
* (done) Repository aufräumen > mehrere Instanzen von createscripts.sh



Bencharks
* R Script zum Aggregieren der Szenarien
* Hardware HDD vs SSD
* Virtualisiert?
* Ram?
* Relative Vergleiche de Performance von ext4 zu btrfs
* BoxPlots?
* Anzahl Replikationen




