# FS Benchmark
Vorm Laufen der Tests: ``sudo sysctl kernel.randomize_va_space=0``  
Nach dem Test: ``sudo sysctl -a --pattern kernel.randomize_va_space=2``, um ASLR wieder zu aktivieren.

## TODOS

- [x] Mehrere Durchläufe in run pro Szenario
- [x] Copyfiles testen
- [x] Einmal durchlaufen lassen
- [x] Gesamtlaufzeit abschätzen (auch pro Szenario)
- [x] Basescripts Konfigurieren
- [x] In run.sh entfernen aller Dateien im Zielordner vor dem Ausführen des filebench befehls
- [x] Repository aufräumen > mehrere Instanzen von createscripts.sh



## Bencharks
- [ ] Anpassen der Scripts fuer randomRW auf 5 / 10 und 15g
- [ ] Hardware HDD vs SSD
- [ ] Virtualisiert?
- [ ] Ram?
- [ ] Relative Vergleiche de Performance von ext4 zu btrfs
- [ ] BoxPlots?
- [ ] Anzahl Replikationen

## Relevante Paper
- [Benchmark](https://www.researchgate.net/publication/304743738_Benchmarking_Performance_of_EXT4_XFS_and_BTRFS_as_Guest_File_Systems_Under_Linux_Environment)
- [btrfs](https://www.usenix.org/system/files/login/articles/bacik_0.pdf)
- [btrfs](https://dl.acm.org/doi/10.1145/2501620.2501623)
- [ext4](https://www.usenix.org/system/files/login/articles/586-mathur.pdf)
- [Filebench](https://www.usenix.org/system/files/login/articles/login_spring16_02_tarasov.pdf)



