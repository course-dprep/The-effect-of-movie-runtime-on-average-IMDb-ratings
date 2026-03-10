TEMP = gen/temp
DATA = data
SRC = src/data-preparation

$(TEMP)/movies_main_clean.csv: $(DATA)/title.ratings.tsv.gz $(DATA)/title.basics.tsv.gz $(SRC)/data-cleaning.R
	Rscript $(SRC)/data-cleaning.R