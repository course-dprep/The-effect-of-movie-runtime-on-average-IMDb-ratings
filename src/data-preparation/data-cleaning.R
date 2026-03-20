# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

library(readr)
library(dplyr)
library(tidyr)

dir.create("../../gen/temp", recursive = TRUE, showWarnings = FALSE)
dir.create("../../gen/output", recursive = TRUE, showWarnings = FALSE)

# ---------------------------------------------------------
# 2. Load raw data
# ---------------------------------------------------------
basics  <- read_tsv("../../data/title.basics.tsv.gz",
                    na = "\\N",
                    show_col_types = FALSE)

ratings <- read_tsv("../../data/title.ratings.tsv.gz",
                    show_col_types = FALSE)

# ---------------------------------------------------------
# 3. Merge datasets using tconst
# ---------------------------------------------------------
combined_dataset <- full_join(basics, ratings, by = "tconst")


# ---------------------------------------------------------
# 4. Keep only movies
# ---------------------------------------------------------
movies <- combined_dataset %>%
  filter(titleType == "movie")


# ---------------------------------------------------------
# 5. Create main genre (first listed genre only)
#    This avoids duplicate observations caused by
#    multiple genres per film.
# ---------------------------------------------------------

movies_main <- movies %>%
  filter(!is.na(genres)) %>%
  mutate(
    main_genre = sub(",.*", "", genres),  # take first genre before comma
    main_genre = as.factor(main_genre)
  )


# ---------------------------------------------------------
# 6. Clean variables and prepare for analysis
# ---------------------------------------------------------

movies_main_clean <- movies_main %>%
  mutate(
    runtimeMinutes = as.numeric(runtimeMinutes),
    log_votes = log(numVotes + 1),
    startYear = as.numeric(startYear)
  ) %>%
  filter(
    !is.na(runtimeMinutes),
    !is.na(averageRating),
    !is.na(numVotes),
    !is.na(startYear)
  )

# Filter runtime outliers (based on inspection of quantiles)
movies_main_clean <- movies_main_clean %>%
  filter(runtimeMinutes >= 40,
         runtimeMinutes <= 240)

# ---------------------------------------------------------
# 7. Inspect dataset size and genre distribution
# ---------------------------------------------------------
nrow(movies_main_clean)
sort(table(movies_main_clean$main_genre), decreasing = TRUE)


# ---------------------------------------------------------
# 8. Reduce genres to Top 10 + "Other"
# ---------------------------------------------------------
top_genres <- names(sort(table(movies_main_clean$main_genre), decreasing = TRUE))[1:10]

movies_main_top <- movies_main_clean %>%
  mutate(
    genre10 = ifelse(main_genre %in% top_genres, 
                     as.character(main_genre), 
                     "Other"),
    genre10 = as.factor(genre10)
  )

table(movies_main_top$genre10)

# ---------------------------------------------------------
# 9. Save cleaned data
# ---------------------------------------------------------
write.csv(movies_main_top, "../../gen/temp/movies_main_top.csv", row.names = FALSE)
