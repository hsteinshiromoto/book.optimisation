
xelatex: 
	cd latex && xelatex main.tex

index: xelatex
	cd latex && makeindex main.idx
	make xelatex

nomenclature: xelatex
	cd latex && makeindex main.nlo -s nomencl.ist -o main.nls
	make xelatex

bibliography: xelatex
	cd latex && biber main
	make xelatex

all: xelatex index nomenclature bibliography

.PHONY: xelatex