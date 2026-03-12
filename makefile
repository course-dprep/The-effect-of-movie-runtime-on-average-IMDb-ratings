all: data-preparation analysis

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
