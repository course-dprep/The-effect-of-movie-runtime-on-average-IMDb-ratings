# This script will be used to populate the \data directory
# with all necessary raw data files.

# This script populates the /data directory with the required IMDb raw files of title ratings and title basics.

library(readr)
library(dplyr)
library(tidyr)

# ---------------------------------------------------------
# 1. Define URLs and destinations and download using a loop
# ---------------------------------------------------------

urls <- c(
  ratings = "https://datasets.imdbws.com/title.ratings.tsv.gz",
  basics  = "https://datasets.imdbws.com/title.basics.tsv.gz"
)

destinations <- c(
  ratings = "../../data/title.ratings.tsv.gz",
  basics  = "../../data/title.basics.tsv.gz"
)

for (name in names(urls)) {
  download.file(urls[name], destfile = destinations[name], mode = "wb")
}

# ---------------------------------------------------------
# 2. Import ratings dataset
#    Contains: tconst, averageRating, numVotes
# ---------------------------------------------------------

ratings <- read_tsv(destinations["ratings"], show_col_types = FALSE)

# ---------------------------------------------------------
# 3. Import basics dataset
# ---------------------------------------------------------

basics <- read_tsv(destinations["basics"], na = "\\N", show_col_types = FALSE)