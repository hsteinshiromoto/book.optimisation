
main_filename = main

xelatex: 
	cd latex && xelatex $(main_filename).tex

index: xelatex
	cd latex && makeindex $(main_filename).idx
	make xelatex

nomenclature: xelatex
	cd latex && makeindex $(main_filename).nlo -s nomencl.ist -o $(main_filename).nls
	make xelatex

bibliography: xelatex
	cd latex && biber $(main_filename)
	make xelatex

all: xelatex index nomenclature bibliography

.PHONY: xelatex