TEMP = ../../gen/temp
OUTPUT = ../../gen/output

all: $(OUTPUT)/analysis_results.txt $(OUTPUT)/model_diagnostics.pdf $(OUTPUT)/runtime_vs_rating.pdf $(OUTPUT)/rating_by_genre.pdf

$(OUTPUT)/analysis_results.txt $(OUTPUT)/model_diagnostics.pdf $(OUTPUT)/runtime_vs_rating.pdf $(OUTPUT)/rating_by_genre.pdf: analysis.R $(TEMP)/movies_main_top.rds
	R -e "dir.create('$(OUTPUT)', recursive = TRUE, showWarnings = FALSE)"
	Rscript analysis.R