TEMP = gen/temp
SRC_ANALYSIS = src/analysis

$(TEMP)/analysis_results.txt: $(TEMP)/movies_main_clean.rds $(SRC_ANALYSIS)/analysis.R
	Rscript $(SRC_ANALYSIS)/analysis.R