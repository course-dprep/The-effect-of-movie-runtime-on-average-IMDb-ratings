all: data-preparation analysis report

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis

report: analysis
	R -e "dir.create('gen/temp', recursive = TRUE, showWarnings = FALSE)"
	Rscript -e "rmarkdown::render('reporting/final_report.Rmd', output_format = 'pdf_document', output_file = 'final_report.pdf', output_dir = 'gen/temp')"

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
	
