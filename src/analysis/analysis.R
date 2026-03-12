# In this directory, you will keep all source code related to your analysis.

library(readr)
library(dplyr)
library(tidyr)

# =========================================================
# DATA ANALYSIS: LINEAR REGRESSION
# =========================================================

# ---------------------------------------------------------
# 1. Load prepared data
# ---------------------------------------------------------

movies_main_top <- readRDS("../../gen/temp/movies_main_top.rds")

results_file <- "../../gen/output/analysis_results.txt"
diagnostics_file <- "../../gen/output/model_diagnostics.pdf"
scatter_file <- "../../gen/output/runtime_vs_rating.pdf"
boxplot_file <- "../../gen/output/rating_by_genre.pdf"

# ---------------------------------------------------------
# 2. Correlations
# ---------------------------------------------------------

cor_runtime_rating <- cor(
  movies_main_top$runtimeMinutes,
  movies_main_top$averageRating,
  use = "complete.obs"
)

cor_votes_rating <- cor(
  movies_main_top$log_votes,
  movies_main_top$averageRating,
  use = "complete.obs"
)

# ---------------------------------------------------------
# 3. Linear regression models
# ---------------------------------------------------------

# Model 1: effect of runtime on rating
model_1 <- lm(
  averageRating ~ runtimeMinutes,
  data = movies_main_top
)

# Model 2: add control variable
model_2 <- lm(
  averageRating ~ runtimeMinutes + log_votes,
  data = movies_main_top
)

# Model 3: full model with moderator and control
model_3 <- lm(
  averageRating ~ runtimeMinutes * genre10 + log_votes,
  data = movies_main_top
)

# ---------------------------------------------------------
# 4. Save text output 
# ---------------------------------------------------------

sink(results_file)

cat("Correlation between runtime and average rating:\n")
print(cor_runtime_rating)
cat("\n")

cat("Correlation between log votes and average rating:\n")
print(cor_votes_rating)
cat("\n")

cat("Model 1 summary:\n")
print(summary(model_1))
cat("\n")

cat("Model 2 summary:\n")
print(summary(model_2))
cat("\n")

cat("Model 3 summary:\n")
print(summary(model_3))
cat("\n")

cat("ANOVA comparison:\n")
print(anova(model_1, model_2, model_3))
cat("\n")

sink()

# ---------------------------------------------------------
# 5. Save plots
# ---------------------------------------------------------

pdf(diagnostics_file)
par(mfrow = c(2, 2))
plot(model_3)
dev.off()

pdf(scatter_file)
par(mfrow = c(1, 1))

plot(
  movies_main_top$runtimeMinutes,
  movies_main_top$averageRating,
  pch = 20,
  cex = 0.4,
  xlab = "Runtime (minutes)",
  ylab = "Average Rating",
  main = "Runtime vs Average IMDb Rating"
)

abline(
  lm(averageRating ~ runtimeMinutes, data = movies_main_top),
  col = "red",
  lwd = 2
)

dev.off()

pdf(boxplot_file)

boxplot(
  averageRating ~ genre10,
  data = movies_main_top,
  outline = FALSE,
  las = 2,
  main = "Average Rating by Genre (Top 10 + Other)",
  ylab = "Average Rating"
)

dev.off()