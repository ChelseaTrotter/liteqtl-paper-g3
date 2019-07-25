lm.pdf: paper.tex styles/*
	pdflatex -shell-escape paper.tex
	bibtex paper
	pdflatex -shell-escape paper.tex
	pdflatex -shell-escape paper.tex
