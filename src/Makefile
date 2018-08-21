# Dependencies (Debian Stretch)
# sudo apt install texlive-xetex texlive-bibtex-extra texlive-fonts-extra biber

main_filename = main

docker_user = hsteinshiromoto
repo = tex
tag = latest

container_name = tex

check-packages:
	dpkg -l | grep texlive-xetex
	dpkg -l | grep texlive-bibtex-extra -c
	dpkg -l | grep texlive-fonts-extra -c 
	dpkg -l | grep biber -c 

run:
	docker run -v $(PWD):/home --name $(container_name) -t -d $(docker_user)/$(repo):$(tag)

xelatex:
	# cd latex && xelatex $(main_filename).tex
	docker exec -it $(container_name) cd latex && xelatex $(main_filename).tex

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