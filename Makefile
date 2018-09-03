# Dependencies (Debian Stretch)
# sudo apt install texlive-xetex texlive-bibtex-extra texlive-fonts-extra biber

main_filename = main

docker_image = hsteinshiromoto/tex:latest

container_name = tex

container_id = $(shell docker ps -qf "ancestor=$(docker_image)")

check-packages:
	dpkg -l | grep texlive-xetex
	dpkg -l | grep texlive-bibtex-extra -c
	dpkg -l | grep texlive-fonts-extra -c 
	dpkg -l | grep biber -c 

run:
	docker run -v $(PWD):/home \
			   -t -d $(docker_image)

xelatex:
	# cd latex && xelatex $(main_filename).tex
	docker exec -i $(container_id) \
		   bash -c "cd src/latex && xelatex $(main_filename).tex"

index: xelatex
	# cd src/latex && makeindex $(main_filename).idx
	docker exec -i $(container_id) \
		   bash -c "cd src/latex && makeindex $(main_filename).idx"
	make xelatex

nomenclature: xelatex
	# cd src/latex && makeindex $(main_filename).nlo -s nomencl.ist -o $(main_filename).nls
	docker exec -i $(container_id) \
		   bash -c "cd src/latex && makeindex $(main_filename).nlo -s nomencl.ist -o $(main_filename).nls"
	make xelatex

bibliography: xelatex
	cd src/latex && biber $(main_filename)
	make xelatex

all: xelatex index nomenclature bibliography

.PHONY: xelatex