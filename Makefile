report.pdf: report.tex myplot.png marineHeatWaves.py
	latexmk -pdf

myplot.png: data.txt plot.py c44255.csv
	python plot.py

data.txt: makedata.py
	python makedata.py

c44255.csv:
	curl -O http://www.meds-sdmm.dfo-mpo.gc.ca/alphapro/wave/waveshare/csvData/c44255_csv.zip
	unzip c44255_csv.zip
	rm c44255_csv.zip

marineHeatWaves.py:
	wget https://raw.githubusercontent.com/ecjoliver/marineHeatWaves/master/marineHeatWaves.py

.PHONY: clean almost_clean

clean: almost_clean
	rm report.pdf
	rm myplot.png

almost_clean:
	latexmk -c
