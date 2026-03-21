[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)

# The effect of movie runtime on average IMDb ratings.
The goal of this study is to examine the extent to which movie runtime predicts average IMDb ratings, and whether this relationship is moderated by genre, while controlling for the number of user votes.

## Motivation
Online ratings of films play an important role in shaping consumer viewing decisions and influencing recommendation systems on streaming platforms. It is therefore relevant to examine which characteristics of audiovisual content are associated with higher audience ratings. One relevant characteristic is runtime. Research by Moon et al. (2009) shows that longer films tend to receive higher ratings on average, possibly because they are perceived by viewers as more valuable and narratively complex. While a longer runtime may contribute to greater narrative depth, prolonged exposure to audiovisual stimuli may, according to the Attention Restoration Theory, also lead to cognitive fatigue and reduced viewer attention (Baumgartner & Kühne, 2024). This could influence how viewers evaluate the quality of a film or television production. The relationship between runtime and ratings is likely to differ by genre, as different genres create distinct expectations regarding narrative pacing, story development, and ideal length.

The research question is therefore formulated as follows: **“To what extent does runtime (dv) predict the average IMDb rating of films (iv) and to what extent is this relationship moderated by genre?”**

This research question aligns with the available IMDb datasets and focuses on whether the length of a movie is related to perceived quality, as reflected in average IMDb ratings. In addition, the number of votes may affect the reliability of ratings. A small number of votes can produce more extreme or biased evaluations. Therefore, the number of votes is included as a control variable. The findings of this research are relevant for both consumers interpreting online ratings and platforms that rely on rating-based recommendation algorithms.

## Data
The data used in this study are obtained from the [official IMDb datasets](https://datasets.imdbws.com/), specifically we used these two datasets:
- [title.basics.tsv.gz](https://datasets.imdbws.com/title.basics.tsv.gz)
- [title.ratings.tsv.gz](https://datasets.imdbws.com/title.ratings.tsv.gz)

These datasets are programmatically downloaded within the R script to ensure full reproducibility. The title.basics dataset contains **12,373,014** observations and includes information on title characteristics such as title type, runtime, and genre. The title.ratings dataset contains **1,650,357** observations and provides the average user rating and the number of user votes. The two datasets are merged using the unique identifier tconst.

To ensure a consistent and comparable sample, the analysis is restricted to movies (titleType = "movie"). Titles with missing values for runtime, average rating, or number of votes are excluded.

Because IMDb assigns multiple genres to some titles, only the first listed genre is retained as the primary genre classification to avoid duplicate observations and ensure one observation per film. After cleaning and filtering, the final merged dataset contains **299,473** unique movie observations.

### Dependent variable - Rating (averageRating)
The dependent variable is the average IMDb user rating of a movie, measured on a continuous scale from 1 to 10. This variable captures audience evaluation of the content.

### Independent variable - Runtime (runtimeMinutes)
The independent variable is the runtime of a movie, measured in minutes and treated as a continuous variable. Runtime represents the total duration of the content.

### Control variable - Number of votes (numVotes)
This control variable measures the total number of IMDb user votes and captures the popularity and visibility of a title. Due to its strongly skewed distribution, it is log-transformed (log_votes = log(numVotes + 1)) prior to inclusion in the regression analysis, improving robustness against the influence of extreme values.

### Control variable – Release year (startYear)
Release year of the movie is included as an additional control variable, measured by `startYear`. This variable captures the year in which the movie was released. The control variable is treated as a continuous variable and it accounts for potential temporal trends in iMDb ratings, as it may be that audience evaluation standards and rating behaviour may have changed over time. 

### Moderator - Genre (genre)
Genre is included as a moderating variable to test whether the relationship between runtime and rating differs across movie types. Since IMDb allows multiple genres per title, only the first listed genre is used as the primary genre classification in order to preserve one observation per film.

Genre is treated as a categorical variable and operationalised using dummy variables in the regression analysis, with one genre serving as the reference category. For interpretability, genres are grouped into the ten most frequent categories, with all remaining genres combined into an `"Other"` category.

## Method
To answer the research question, linear regression analysis is employed, as both the dependent variable (average IMDb rating) and the independent variable (runtime in minutes) are continuous. Prior to analysis, the data were prepared through several cleaning steps. The two IMDb datasets (title.basics and title.ratings) were merged using the unique identifier tconst and filtered to retain only feature films (titleType = "movie"). Runtime outliers were removed by restricting observations to films between 40 and 240 minutes, based on inspection of the empirical quantile distribution. Titles with missing values on runtime, average rating, number of votes, or release year were excluded via listwise deletion, yielding a final analytic sample of 299,473 films.

To address the skewed distribution of the number of votes, this variable was log-transformed (log_votes = log(numVotes + 1)) before inclusion as a control variable, improving the normality of its distribution and reducing the influence of highly voted outliers. Because IMDb assigns multiple genres per title, only the first-listed genre was retained as the primary genre classification (main_genre) to maintain one observation per film. Genres were subsequently grouped into the ten most frequent categories, with all remaining genres collapsed into an "Other" category, resulting in an eleven-level categorical moderator (genre10).

The moderation hypothesis is tested by including interaction terms between runtime and genre in the regression model, allowing the slope of runtime to vary across genre categories. Release year was additionally examined as a potential covariate through correlation analysis. All analyses were conducted in R (version 4.0 or higher).

## Preview of Findings  
Preliminary analysis shows that the relationship between runtime and average IMDb rating is statistically very weak. The Pearson correlation between runtime and average rating is approximately r = 0.008, which is very close to zero and indicates that longer movies do not systematically receive higher ratings. This challenges the assumption that longer films tend to be rated more favourably (Moon et al., 2009), suggesting that runtime is not a reliable determinant of perceived quality.

This pattern is also visible in the scatterplot (see gen/output/runtime_vs_rating.png), where the regression line shows only a slight positive trend and the data points are widely dispersed. This suggests substantial unexplained variation in ratings across movies with similar runtimes. In other words, runtime alone does not appear to be a strong predictor of the average IMDb rating of a movie.

The correlation between the log-transformed number of votes and average rating is approximately -0.08, indicating a very small negative relationship. This may reflect a diversification effect, whereby wider viewership introduces more heterogeneous and critical evaluations. Including the number of votes as a control variable is therefore analytically important, as it isolates the effect of runtime from variation in title visibility, thereby strengthening the internal validity of the estimates.

As shown in the boxplot (see gen/output/rating_by_genre.png), average ratings vary substantially across genres. For example, the average ratings of the genres Biography and Documentary are noticeably higher than those of Horror. This suggests that genre may play an important moderating role in the relationship between runtime and rating.

Further analysis shows trends over time (see gen/output/year_vs_rating.png).

Finally, we assess the validity of the regression model (see gen/output/model_diagnostics.png).

## Reproducibility
The findings of this study are presented in a structured R Markdown report. In this report, the complete data analysis is documented step by step. The report includes data preparation, descriptive statistics, regression analysis, and visualisations such as scatterplots and boxplots.

Furthermore, the workflow is fully reproducible. The IMDb data can be downloaded automatically and analysed through the script. This allows other researchers to replicate the study easily or extend the analysis using different selection criteria, such as focusing on a specific genre. All scripts are version-controlled using Git and hosted in a public GitHub repository, ensuring full transparency and accessibility of the analytical workflow.

## Interpretation and relevance
The findings suggest that runtime, on its own, is a very weak predictor of the average IMDb rating. This is relevant because it challenges the assumption that longer movies necessarily receive higher ratings (Moon et al., 2009). In practical terms, this indicates that longer runtime is not a reliable strategy for achieving higher ratings.

In addition, the results show substantial variation in ratings across genre categories. This implies that general statements about an “ideal movie length” may be misleading and that such conclusions should instead be approached in a genre-specific manner.

Including the number of votes as a control variable is essential for a more accurate interpretation of the results. By controlling for the number of votes, the effect of runtime is estimated while accounting for variation in title visibility and popularity, which strengthens the internal validity of the analysis. Including the release year as an additional control variable further strenghtens the analysis by accounting for potential changes in rating behaviour over time. Together, these two control variables help ensure that the estimated effect of runtime on average rating is not confounded by differences in movie popularity or the time period in which a film was released.

## Repository Overview 
The repository is organised to ensure reproducibility and transparency. Scripts for data acquisition, preparation, and analysis are separated into dedicated subdirectories, and the master makefile automates the complete pipeline from data download to final output.

```
imdb-runtime-rating/
│
├── data/                            # Raw and downloaded data files
│   ├── title.basics.tsv.gz          # IMDb basics dataset (auto-downloaded)
│   └── title.ratings.tsv.gz         # IMDb ratings dataset (auto-downloaded)
│
├── reporting/                       # R Markdown reports
│   ├── data_exploration.Rmd         # Exploratory data analysis and visualisations
│   └── final_report.Rmd             # Full documented analysis report
│
├── src/                             # Source code
│   ├── analysis/                    # Statistical modelling scripts
│   │   ├── analysis.R               # Linear regression and moderation analysis
│   │   └── makefile                 # Pipeline automation for analysis step
│   │
│   └── data-preparation/            # Data cleaning and preparation scripts
│       ├── data-cleaning.R          # Filtering, merging, variable construction
│       ├── download-data.R          # Automated download of IMDb datasets
│       └── makefile                 # Pipeline automation for preparation step
│
├── .gitignore                       # Files excluded from version control
├── README.md                        # Project documentation and running instructions
└── makefile                         # Master pipeline automation
```

## Dependencies 
This project was developed using R (version 4.2.0 or higher) and RStudio. The following R packages are required to run the workflow:

- `readr` for importing the IMDb .tsv.gz datasets
- `dplyr` for data filtering, merging, and variable construction
- `tidyr` for data reshaping and handling missing values
- `rmarkdown` for rendering the R Markdown reports
- `knitr` for document knitting and output generation

If any of these packages are not yet installed, they can be installed collectively using:
```
install.packages(c("readr", "dplyr", "tidyr", "rmarkdown", "knitr"))
```

## Running Instructions 
To reproduce the results of this workflow, follow these steps:

**Step 1: Clone the repository**

Using Command Prompt (Windows) or Terminal (Mac), clone the repository to your local machine:
```
git clone https://github.com/course-dprep/The-effect-of-movie-runtime-on-average-IMDb-ratings.git
```
Once cloned, all necessary folders and scripts will be available locally.

**Step 2: Download the IMDb datasets**

Navigate to src/data-preparation/ and run download-data.R. This script automatically creates a data/ folder and downloads the required IMDb datasets:
```
# Create data folder
dir.create("data", showWarnings = FALSE, recursive = TRUE)

# Download IMDb datasets
download.file("https://datasets.imdbws.com/title.basics.tsv.gz",
              "data/title.basics.tsv.gz")

download.file("https://datasets.imdbws.com/title.ratings.tsv.gz",
              "data/title.ratings.tsv.gz")
```

**Step 3: Load packages and read data** 

Run data-cleaning.R to load the required packages and import the downloaded datasets into RStudio:
```
# Load required libraries
library(readr)
library(dplyr)
library(tidyr)

# Read datasets
basics  <- read_tsv("data/title.basics.tsv.gz", na = "\\N")
ratings <- read_tsv("data/title.ratings.tsv.gz", na = "\\N")
```
After completing these steps, the full analysis pipeline, including data merging, cleaning, variable construction, and regression analysis can be reproduced by knitting final_report.Rmd in RStudio or by executing the master makefile from the terminal. No manual data preprocessing is required.

## About 
This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 1 members: 
- Bente van Brussel: b.j.m.vanbrussel@tilburguniversity.edu
- Niels Deenen: n.deenen@tilburguniversity.edu
- David Lindwer: d.j.lindwer@tilburguniversity.edu
- Demi Verburg: d.verburg@tilburguniveristy.edu
- Marijn van Dooren: m.vandooren@tilburguniversity.edu
