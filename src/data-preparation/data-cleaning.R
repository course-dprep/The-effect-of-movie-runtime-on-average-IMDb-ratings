# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

library(readr)
library(dplyr)
library(tidyr)

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
    log_votes = log(numVotes + 1)
  ) %>%
  filter(
    !is.na(runtimeMinutes),
    !is.na(averageRating),
    !is.na(numVotes),
  )


# Save cleaned data for later scripts
saveRDS(movies_main_top, "data/imdb_movies_clean.rds")
