library(readr)
library(dplyr)
library(tidyr)


# ---------------------------------------------------------
# 1. Download and import ratings dataset
#    Contains: tconst, averageRating, numVotes
# ---------------------------------------------------------

```{r}
url_ratings  <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
dest_ratings <- "data/title.ratings.tsv.gz"
download.file(url_ratings, destfile = dest_ratings, mode = "wb")

ratings <- read_tsv(dest_ratings, show_col_types = FALSE)

```

# ---------------------------------------------------------
# 2. Download and import basics dataset
# ---------------------------------------------------------

```{r}
url_basics  <- "https://datasets.imdbws.com/title.basics.tsv.gz"
dest_basics <- "data/title.basics.tsv.gz"
download.file(url_basics, destfile = dest_basics, mode = "wb")

basics <- read_tsv(dest_basics, na = "\\N", show_col_types = FALSE)
```
