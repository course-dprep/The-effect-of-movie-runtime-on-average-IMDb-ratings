# This script will be used to populate the \data directory
# with all necessary raw data files.

# This script populates the /data directory with the required IMDb raw files.

dir.create("data", showWarnings = FALSE, recursive = TRUE)

# 1) Ratings dataset
url_ratings  <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
dest_ratings <- "data/title.ratings.tsv.gz"
if (!file.exists(dest_ratings)) {
  download.file(url_ratings, destfile = dest_ratings, mode = "wb")
}

# 2) Basics dataset
url_basics  <- "https://datasets.imdbws.com/title.basics.tsv.gz"
dest_basics <- "data/title.basics.tsv.gz"
if (!file.exists(dest_basics)) {
  download.file(url_basics, destfile = dest_basics, mode = "wb")
}
