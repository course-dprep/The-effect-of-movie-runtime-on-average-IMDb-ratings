DATA = ../../data
TEMP = ../../gen/temp

all: $(TEMP)/movies_main_top.csv

$(DATA)/title.basics.tsv.gz $(DATA)/title.ratings.tsv.gz: download-data.R
	R -e "dir.create('$(DATA)', recursive = TRUE, showWarnings = FALSE)"
	Rscript download-data.R

$(TEMP)/movies_main_top.csv: data-cleaning.R $(DATA)/title.ratings.tsv.gz $(DATA)/title.basics.tsv.gz
	R -e "dir.create('$(TEMP)', recursive = TRUE, showWarnings = FALSE)"
	Rscript data-cleaning.R