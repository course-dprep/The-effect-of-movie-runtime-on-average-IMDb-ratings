TEMP = ../../gen/temp
OUTPUT = ../../gen/output

all: $(OUTPUT)/analysis_results.txt $(OUTPUT)/model_diagnostics.png $(OUTPUT)/runtime_vs_rating.png $(OUTPUT)/rating_by_genre.png $(OUTPUT)/year_vs_rating.png

$(OUTPUT)/analysis_results.txt $(OUTPUT)/model_diagnostics.png $(OUTPUT)/runtime_vs_rating.png $(OUTPUT)/rating_by_genre.png $(OUTPUT)/year_vs_rating.png: analysis.R $(TEMP)/movies_main_top.csv
	R -e "dir.create('$(OUTPUT)', recursive = TRUE, showWarnings = FALSE)"
	Rscript analysis.R