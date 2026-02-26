# In this directory, you will keep all source code related to your analysis.

---
title: "The-effect-of-movie-runtime-on-average-IMDb-ratings"
output:
  pdf_document: default
  html_document: default
date: "2026-02-18"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(readr)
library(dplyr)
library(tidyr)

dir.create("data", showWarnings = FALSE)
```

# =========================================================
# DATA PREPARATION
# =========================================================

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

# ---------------------------------------------------------
# 3. Merge datasets using tconst
# ---------------------------------------------------------

```{r}
combined_dataset <- full_join(basics, ratings, by = "tconst")
```

# ---------------------------------------------------------
# 4. Keep only movies
# ---------------------------------------------------------

```{r}
movies <- combined_dataset %>%
  filter(titleType == "movie")
```

# ---------------------------------------------------------
# 5. Create main genre (first listed genre only)
#    This avoids duplicate observations caused by
#    multiple genres per film.
# ---------------------------------------------------------

```{r}
movies_main <- movies %>%
  filter(!is.na(genres)) %>%
  mutate(
    main_genre = sub(",.*", "", genres),  # take first genre before comma
    main_genre = as.factor(main_genre)
  )

```

# ---------------------------------------------------------
# 6. Clean variables and prepare for analysis
# ---------------------------------------------------------

```{r}
movies_main_clean <- movies_main %>%
  mutate(
    runtimeMinutes = as.numeric(runtimeMinutes),
    log_votes = log(numVotes + 1)
  ) %>%
  filter(
    !is.na(runtimeMinutes),
    !is.na(averageRating),
    !is.na(numVotes)
  )
```

# ---------------------------------------------------------
# 7. Inspect dataset size and genre distribution
# ---------------------------------------------------------

```{r}
nrow(movies_main_clean)
sort(table(movies_main_clean$main_genre), decreasing = TRUE)
```

# ---------------------------------------------------------
# 8. Reduce genres to Top 10 + "Other"
# ---------------------------------------------------------

```{r}
top_genres <- names(sort(table(movies_main_clean$main_genre), decreasing = TRUE))[1:10]

movies_main_top <- movies_main_clean %>%
  mutate(
    genre10 = ifelse(main_genre %in% top_genres, 
                     as.character(main_genre), 
                     "Other"),
    genre10 = as.factor(genre10)
  )

table(movies_main_top$genre10)
```
# =========================================================
# DATA EXPLORATION
# =========================================================

# ---------------------------------------------------------
# 1. General overview
# ---------------------------------------------------------

```{r}
dim(movies_main_clean)
glimpse(movies_main_clean)
summary(movies_main_clean)
```

# ---------------------------------------------------------
# 2. Missing values check
# ---------------------------------------------------------
```{r}
colSums(is.na(movies_main_clean[, 
                                c("averageRating",
                                  "runtimeMinutes",
                                  "numVotes",
                                  "log_votes",
                                  "main_genre")]))
```
# ---------------------------------------------------------
# 3. Descriptive statistics
# ---------------------------------------------------------
```{r}
summary(movies_main_clean$averageRating)
summary(movies_main_clean$runtimeMinutes)
summary(movies_main_clean$numVotes)
summary(movies_main_clean$log_votes)

```

# ---------------------------------------------------------
# 4. numVotes vs log_votes distribution
# ---------------------------------------------------------
```{r}
par(mfrow = c(1,2))
hist(movies_main_clean$numVotes,
     main = "Distribution of numVotes",
     xlab = "numVotes")
```
```{r}
hist(movies_main_clean$log_votes,
     main = "Distribution of log(numVotes+1)",
     xlab = "log_votes")
par(mfrow = c(1,1))
```
# ---------------------------------------------------------
# 5. Runtime distribution + extreme values
# ---------------------------------------------------------
```{r}
hist(movies_main_clean$runtimeMinutes,
     main = "Distribution of runtimeMinutes",
     xlab = "Runtime (minutes)")
```
```{r}
quantile(movies_main_clean$runtimeMinutes,
         probs = c(.01, .05, .50, .95, .99),
         na.rm = TRUE)
```


# ---------------------------------------------------------
# 6. Genre distribution
# ---------------------------------------------------------
```{r}
sort(table(movies_main_clean$main_genre), decreasing = TRUE)
```
# ---------------------------------------------------------
# 7. Genre distribution after grouping
# ---------------------------------------------------------
```{r}
if (exists("movies_main_top")) {
  table(movies_main_top$genre10)
  prop.table(table(movies_main_top$genre10))
}

```
# ---------------------------------------------------------
# 8. Focus on Comedy
# ---------------------------------------------------------

```{r}
comedy_only <- movies_main_clean %>%
  filter(main_genre == "Comedy")

dim(comedy_only)
summary(comedy_only$averageRating)
summary(comedy_only$runtimeMinutes)
summary(comedy_only$log_votes)

plot(comedy_only$runtimeMinutes,
     comedy_only$averageRating,
     xlab = "Runtime (minutes)",
     ylab = "Average rating",
     main = "Comedy: runtime vs rating")

```
# ---------------------------------------------------------
# 9. Effect of Runtime on Average IMDb Rating
# ---------------------------------------------------------
```{r}
plot(movies_main_clean$runtimeMinutes,
     movies_main_clean$averageRating,
     pch = 20,
     cex = 0.4,
     xlab = "Runtime (minutes)",
     ylab = "Average Rating",
     main = "Runtime vs Average IMDb Rating")

abline(lm(averageRating ~ runtimeMinutes,
          data = movies_main_clean),
       col = "red",
       lwd = 2)
```

# ---------------------------------------------------------
# 10. Control Variable Check: Votes vs Rating
# ---------------------------------------------------------
```{r}
cor(movies_main_clean$log_votes,
    movies_main_clean$averageRating,
    use = "complete.obs")

plot(movies_main_clean$log_votes,
     movies_main_clean$averageRating,
     pch = 20,
     cex = 0.4,
     xlab = "Log(Number of Votes)",
     ylab = "Average Rating",
     main = "Votes vs Rating")
```

# ---------------------------------------------------------
# 11. Compare ratings across genres
# ---------------------------------------------------------
```{r}
if (exists("movies_main_top")) {
  boxplot(averageRating ~ genre10,
          data = movies_main_top,
          outline = FALSE,
          las = 2,
          main = "Average rating by genre (Top 10 + Other)",
          ylab = "Average rating")
}

```
# ---------------------------------------------------------
# 12. Simple correlations
# ---------------------------------------------------------

```{r}
cor(movies_main_clean$runtimeMinutes,
    movies_main_clean$averageRating,
    use = "complete.obs")

cor(movies_main_clean$log_votes,
    movies_main_clean$averageRating,
    use = "complete.obs")

```
