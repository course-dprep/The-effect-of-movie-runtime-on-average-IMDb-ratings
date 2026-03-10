# This makefile will be used to automate the
# different steps in your project.
DATA = data
SRC = src/data-preparation

$(DATA)/title.ratings.tsv.gz $(DATA)/title.basics.tsv.gz: $(DATA)/download-data.R
	Rscript $(DATA)/download-data.R