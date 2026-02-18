# This script will be used to populate the \data directory
# with all necessary raw data files.

# Load required libraries
library(readr)

# Create data directory if it doesn't exist
dir.create("data", showWarnings = FALSE)

# ============================================
# 1) Ratings
# ============================================
url_ratings  <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
dest_ratings <- "data/title.ratings.tsv.gz"

download.file(url_ratings, destfile = dest_ratings, mode = "wb")
ratings <- read_tsv(dest_ratings, show_col_types = FALSE)

cat("✓ Ratings data downloaded and loaded\n")

# ============================================
# 2) Basics
# ============================================
url_basics  <- "https://datasets.imdbws.com/title.basics.tsv.gz"
dest_basics <- "data/title.basics.tsv.gz"

download.file(url_basics, destfile = dest_basics, mode = "wb")
basics <- read_tsv(dest_basics, show_col_types = FALSE)

cat("✓ Basics data downloaded and loaded\n")

# First quick scan
```{r}
# Size & columns
dim(ratings); names(ratings)
dim(basics);  names(basics)

# First rows
head(ratings, 10)
head(basics, 10)

# Structure + type-check
str(ratings)
str(basics)

# Summary
summary(ratings)
summary(basics)

# Missing values
```{r}
library(dplyr)

# Check how many "\N" values are in each column
count_N <- function(df) {
  sapply(df, function(x) sum(x == "\\N", na.rm = TRUE))
}

count_N(basics)

# Convert "\N" to NA in basics (for all character columns)
basics_clean <- basics %>%
  mutate(across(where(is.character), ~ na_if(.x, "\\N")))

# Quick NA check
sapply(basics_clean, function(x) sum(is.na(x)))
```

       # Explore ratings
```{r}
library(dplyr)

# Ratings summary
ratings %>%
  summarise(
    n = n(),
    avg_rating_mean   = mean(averageRating, na.rm = TRUE),
    avg_rating_median = median(averageRating, na.rm = TRUE),
    votes_mean        = mean(numVotes, na.rm = TRUE),
    votes_median      = median(numVotes, na.rm = TRUE)
  )

# Highest-rated titles with at least X votes
ratings %>%
  filter(numVotes >= 50000) %>%
  arrange(desc(averageRating)) %>%
  slice_head(n = 20)
```

       ## Combine the datasets

# Basic join (recommended: keep only titles that exist in both)
```{r}
library(dplyr)

imdb <- basics %>%
  inner_join(ratings, by = "tconst")

imdb <- basics %>%
  left_join(ratings, by = "tconst")

imdb <- ratings %>%
  left_join(basics, by = "tconst")

dim(imdb)
glimpse(imdb)
sum(is.na(imdb$numVotes))        # should be 0 if inner_join
sum(is.na(imdb$averageRating))   # should be 0 if inner_join

View(imdb)
```

       # The datasets ratings and basics were merged into a single dataset called imdb to facilitate more efficient and comprehensive analysis.


## IMDb exploration (basics+ratings combined)
# Quick overview
```{r}
library(dplyr)

glimpse(imdb)
summary(imdb)
View(imdb)

imdb %>% summarise(
  n_titles = n(),
  n_movies = sum(titleType == "movie", na.rm = TRUE),
  n_series = sum(titleType == "tvSeries", na.rm = TRUE),
  min_year = min(startYear, na.rm = TRUE),
  max_year = max(startYear, na.rm = TRUE)
)
```

       # Missing values per column
```{r}
sapply(imdb, function(x) sum(is.na(x))) %>% sort(decreasing = TRUE)
```

       # Most common title types + top years
```{r}
imdb %>% count(titleType, sort = TRUE)

imdb %>%
  count(startYear, sort = TRUE) %>%
  slice_head(n = 25)
```

       # Ratings distribution + vote distribution
```{r}
hist(imdb$averageRating, breaks = 30, main = "Average Rating", xlab = "Rating")
hist(log10(imdb$numVotes + 1), breaks = 40, main = "log10(Votes + 1)", xlab = "log10(Votes+1)")


       # Top per type
```{r}
imdb %>%
  filter(titleType %in% c("movie", "tvSeries"), numVotes >= 10000) %>%
  group_by(titleType) %>%
  arrange(desc(averageRating), desc(numVotes), .by_group = TRUE) %>%
  select(titleType, primaryTitle, startYear, averageRating, numVotes, genres) %>%
  slice_head(n = 15) %>%
  ungroup()
```

       # Genres: split, count, and average rating per genre
```{r}
library(dplyr)
library(tidyr)

imdb_genres <- imdb %>%
  separate_rows(genres, sep = ",") %>%
  filter(!is.na(genres))

# Most common genres
imdb_genres %>%
  count(genres, sort = TRUE) %>%
  slice_head(n = 20)

# Best genres (vote threshold)
imdb %>%
  filter(numVotes >= 5000) %>%
  group_by(genres) %>%
  summarise(
    n_titles = n(),
    avg_rating = mean(averageRating, na.rm = TRUE),
    median_votes = median(numVotes, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_rating)) %>%
  slice_head(n = 20)
```

       # Plots
```{r}
library(dplyr)
library(ggplot2)

imdb_plot <- imdb %>%
  mutate(runtimeMinutes = as.numeric(runtimeMinutes)) %>%
  filter(!is.na(runtimeMinutes),
         !is.na(averageRating),
         runtimeMinutes > 0,
         runtimeMinutes <= 300,     # remove extreme runtimes
         numVotes >= 1000)          # optional: more reliable ratings
```

# Scatterplot runtime vs average rating (with smooth trend) 
```{r}
ggplot(imdb_plot, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.15) +
  geom_smooth(se = TRUE) +
  labs(
    title = "Average Rating vs Runtime (Movies/All Titles)",
    x = "Runtime (minutes)",
    y = "Average Rating"
  ) +
  theme_minimal()
```

       # Same scatter, but show only movies
```{r}
ggplot(filter(imdb_plot, titleType == "movie"),
       aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.15) +
  geom_smooth(se = TRUE) +
  labs(
    title = "Average Rating vs Runtime (Movies Only)",
    x = "Runtime (minutes)",
    y = "Average Rating"
  ) +
  theme_minimal()
```

       # Binned averages: “mean rating per runtime bin”
```{r}
ggplot(filter(imdb_plot, titleType == "movie"),
       aes(x = runtimeMinutes, y = averageRating)) +
  stat_summary_bin(fun = mean, bins = 30, geom = "line") +
  stat_summary_bin(fun = mean, bins = 30, geom = "point") +
  labs(
    title = "Mean Rating by Runtime (Binned, Movies)",
    x = "Runtime (minutes)",
    y = "Mean Average Rating"
  ) +
  theme_minimal()
```

       # Boxplot by runtime groups
```{r}
imdb_bins <- imdb_plot %>%
  mutate(runtime_group = cut(runtimeMinutes,
                             breaks = c(0, 60, 90, 120, 150, 180, 300),
                             labels = c("<=60", "61-90", "91-120", "121-150", "151-180", "181-300"),
                             right = TRUE))

ggplot(filter(imdb_bins, titleType == "movie"),
       aes(x = runtime_group, y = averageRating)) +
  geom_boxplot() +
  labs(
    title = "Average Rating by Runtime Group (Movies)",
    x = "Runtime group (minutes)",
    y = "Average Rating"
  ) +
  theme_minimal()
```

       # Compare types: movies vs tv series
```{r}
ggplot(filter(imdb_plot, titleType %in% c("movie", "tvSeries")),
       aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.15) +
  geom_smooth(se = FALSE) +
  facet_wrap(~ titleType) +
  labs(
    title = "Rating vs Runtime by Title Type",
    x = "Runtime (minutes)",
    y = "Average Rating"
  ) +
  theme_minimal()
```

       
