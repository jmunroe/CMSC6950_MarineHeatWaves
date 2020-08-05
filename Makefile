FIGURES=sst_timeseries.png qc_sst_timeseries.png filtered_sst_timeseries.png \
        mhw_timeseries.png mhw_distribution.png

report.pdf: report.tex $(FIGURES) marineHeatWaves.py
	latexmk -pdf

sst_timeseries.png: sst_timeseries.py data.csv
	python sst_timeseries.py

qc_sst_timeseries.png: qc_sst_timeseries.py data.csv
	python qc_sst_timeseries.py

filtered_sst_timeseries.png: filtered_sst_timeseries.py data.csv
	python filtered_sst_timeseries.py

mhw_timeseries.png: mhws_data.pkl mhw_timeseries.py
	python mhw_timeseries.py

mhw_distribution.png: mhws_data.pkl mhw_distribution.py
	python mhw_distribution.py

mhws_data.pkl: process_data.py data.csv
	python process_data.py

c44255.csv:
	curl -O http://www.meds-sdmm.dfo-mpo.gc.ca/alphapro/wave/waveshare/csvData/c44255_csv.zip
	unzip c44255_csv.zip
	rm c44255_csv.zip

data.csv: c44255.csv
	# extract out the DATE, Q_FLAG, and SSTP columns
	cut -d ',' -f 2,3,23 c44255.csv > data.csv

marineHeatWaves.py:
	wget https://raw.githubusercontent.com/ecjoliver/marineHeatWaves/master/marineHeatWaves.py

.PHONY: clean almost_clean

clean: almost_clean
	rm c44255.csv
	rm report.pdf
	rm $(FIGURES)

almost_clean:
	latexmk -c
