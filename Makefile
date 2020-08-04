report.pdf: report.tex myplot.png
	latexmk -pdf

myplot.png: data.txt plot.py bank.csv
	python plot.py

data.txt: makedata.py
	python makedata.py


bank.csv:
	kaggle datasets download janiobachmann/bank-marketing-dataset
	unzip bank-marketing-dataset.zip
	rm bank-marketing-dataset.zip

.PHONY: clean almost_clean

clean: almost_clean
	rm report.pdf
	rm myplot.png

almost_clean:
	latexmk -c

