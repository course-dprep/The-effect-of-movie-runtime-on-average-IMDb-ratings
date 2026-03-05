# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

library(readr)
library(dplyr)
library(tidyr)

# Load raw data (downloaded by data/download-data.R)
ratings <- read_tsv("data/title.ratings.tsv.gz", show_col_types = FALSE)
basics  <- read_tsv("data/title.basics.tsv.gz", na = "\\N", show_col_types = FALSE)

# Merge + keep only movies + ensure duplication is 0 
combined_dataset <- full_join(basics, ratings, by = "tconst")

stopifnot(sum(duplicated(combined_dataset$tconst)) == 0)

movies_main_clean <- combined_dataset %>%
  filter(titleType == "movie") %>%
  filter(!is.na(genres)) %>%
  mutate(
    main_genre = sub(",.*", "", genres),
    main_genre = as.factor(main_genre),
    runtimeMinutes = as.numeric(runtimeMinutes),
    log_votes = log(numVotes + 1)
  ) %>%
  filter(
    !is.na(runtimeMinutes),
    !is.na(averageRating),
    !is.na(numVotes)
  )

# Top 10 genres + Other
top_genres <- names(sort(table(movies_main_clean$main_genre), decreasing = TRUE))[1:10]

movies_main_top <- movies_main_clean %>%
  mutate(
    genre10 = ifelse(main_genre %in% top_genres, as.character(main_genre), "Other"),
    genre10 = as.factor(genre10)
  )

# Save cleaned data for later scripts
saveRDS(movies_main_top, "data/imdb_movies_clean.rds")
