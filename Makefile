report.pdf: report.tex myplot.png marineHeatWaves.py
	latexmk -pdf

myplot.png: data.txt plot.py 
	python plot.py

data.txt: makedata.py
	python makedata.py

marineHeatWaves.py:
	wget https://raw.githubusercontent.com/ecjoliver/marineHeatWaves/master/marineHeatWaves.py

.PHONY: clean almost_clean

clean: almost_clean
	rm report.pdf
	rm myplot.png

almost_clean:
	latexmk -c
