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
```

# =========================================================
# DATA ANALYSIS: LINEAR REGRESSION
# =========================================================

# ---------------------------------------------------------
# 1. Load prepared data
# ---------------------------------------------------------

movies_main_top <- readRDS("........")

# ---------------------------------------------------------
# 2. Correlations
# ---------------------------------------------------------

cor_runtime_rating <- cor(
  movies$runtimeMinutes,
  movies$averageRating,
  use = "complete.obs"
)

cor_votes_rating <- cor(
  movies$log_votes,
  movies$averageRating,
  use = "complete.obs"
)

print(cor_runtime_rating)
print(cor_votes_rating)

# ---------------------------------------------------------
# 3. Linear regression models
# ---------------------------------------------------------

# Model 1: effect of runtime on rating
model_1 <- lm(
  averageRating ~ runtimeMinutes,
  data = movies
)

# Model 2: add control variable
model_2 <- lm(
  averageRating ~ runtimeMinutes + log_votes,
  data = movies
)

# Model 3: full model with moderator and control
model_3 <- lm(
  averageRating ~ runtimeMinutes * genre10 + log_votes,
  data = movies
)

# Show model results
summary(model_1)
summary(model_2)
summary(model_3)

# ---------------------------------------------------------
# 4. Comparing modles
# ---------------------------------------------------------

anova(model_1, model_2, model_3)

# ---------------------------------------------------------
# 5. Visualization for interpretation
# ---------------------------------------------------------


# Diagnostic plots for the full model
par(mfrow = c(2, 2))
plot(model_3)

# Extra visualizations for interpretation
par(mfrow = c(1, 1))

plot(
  movies$runtimeMinutes,
  movies$averageRating,
  pch = 20,
  cex = 0.4,
  xlab = "Runtime (minutes)",
  ylab = "Average Rating",
  main = "Runtime vs Average IMDb Rating"
)

abline(
  lm(averageRating ~ runtimeMinutes, data = movies),
  col = "red",
  lwd = 2
)

boxplot(
  averageRating ~ genre10,
  data = movies,
  outline = FALSE,
  las = 2,
  main = "Average Rating by Genre (Top 10 + Other)",
  ylab = "Average Rating"
)




