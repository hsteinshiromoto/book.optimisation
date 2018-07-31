import os
import sys
from subprocess import call

if __name__ == "__main__":
	path_src = os.path.dirname(os.path.dirname(__file__))
	path_latex = os.path.join(path_src, "latex")
	os.chdir(path_latex)

	try:
		option = sys.argv[1]
	except IndexError:
		option = "all"

	call(["XeLaTeX", "main.tex"])

	options = ["index", "nomenclature", "biber"]

	if option == "all":
		run_options = options
	else:
		options = list(option)

	for run_opt in options:

		if option == "index":
			call(["makeindex", "main.idx"])
		elif option == "nomenclature":
			call(["makeindex", "main.nlo", "-s", "nomencl.ist", "-o", "main.nls"])
		elif option == "biber":
			call(["biber", "main"])
		elif option == "all":
			continue
		else:
			msg = "Expect option to be in {}. Got {}".format(options, option)
			raise ValueError(msg)

		call(["XeLaTeX", "main.tex"])
	
	
