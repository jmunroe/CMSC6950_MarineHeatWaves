report.pdf: report.tex myplot.png
	latexmk -pdf

myplot.png: data.txt plot.py
	python plot.py

data.txt: makedata.py
	python makedata.py

.PHONY: clean almost_clean

clean: almost_clean
	rm report.pdf
	rm myplot.png

almost_clean:
	latexmk -c

