[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)

# The effect of movie runtime on average IMDb ratings.

## Motivation
Online ratings of films play an important role in shaping consumer viewing decisions and influencing recommendation systems on streaming platforms. It is therefore relevant to examine which characteristics of audiovisual content are associated with higher audience ratings. One relevant characteristic is runtime. Research by Moon et al. (2009) shows that longer films tend to receive higher ratings on average, possibly because they are perceived by viewers as more valuable and narratively complex. While a longer runtime may contribute to greater narrative depth, prolonged exposure to audiovisual stimuli may, according to the Attention Restoration Theory, also lead to cognitive fatigue and reduced viewer attention (Baumgartner & Kühne, 2024). This could influence how viewers evaluate the quality of a film or television production. The relationship between runtime and ratings is likely to differ by genre, as different genres create distinct expectations regarding narrative pacing, story development, and ideal length.

The research question is therefore formulated as follows: “To what extent does runtime predict the average IMDb rating of films and to what extent is this relationship moderated by genre?”

This research question aligns with the available IMDb datasets and focuses on whether the length of a movie is related to perceived quality, as reflected in average IMDb ratings. In addition, the number of votes may affect the reliability of ratings. A small number of votes can produce more extreme or biased evaluations. Therefore, the number of votes is included as a control variable. The findings of this research are relevant for both consumers interpreting online ratings and platforms that rely on rating-based recommendation algorithms.

## Data
The data used in this study are obtained from the official IMDb datasets, specifically title.basics.tsv.gz and title.ratings.tsv.gz. These datasets are programmatically downloaded within the R script to ensure full reproducibility.The title.basics dataset contains information on content characteristics such as title type, runtime, and genres. The title.ratings dataset includes the average user rating and the number of user votes. The two datasets are merged using the unique identifier tconst.

To ensure a consistent and comparable sample, the analysis is restricted to movies (titleType = "movie"). Titles with missing values for runtime, average rating, or number of votes are removed.

IMDb allows multiple genres per title. To avoid duplicate observations and ensure one observation per film, only the first listed genre is used as the primary genre classification (main genre).

After cleaning and filtering, the final dataset contains 299.473 unique movie observations.

### Dependent variable - Rating (averageRating)
The dependent variable is the average IMDb user rating of a movie.
It is measured on a continuous scale from 1 to 10.
This variable captures audience evaluation of the content.

### Independent variable - Runtime (runtimeMinutes)
The independent variable is the runtime of a movie.
It is measured in minutes and treated as a continuous variable.
Runtime represents the length of the content.

### Control variable - Number of votes (numVotes)
This control variable measures the total number of IMDb user votes.
It is a count variable and captures the popularity and visibility of a title.
Due to its skewed distribution, it may be log-transformed in the regression analysis.

### Moderator - Genre (genre)
Genre is included as a moderating variable to test whether the relationship between runtime and rating differs across content types. IMDb allows multiple genres per title. To ensure one observation per film and avoid duplicate entries, we use the first listed genre as the primary genre classification (main genre). Genre is treated as a categorical variable and operationalised using dummy variables in the regression analysis, with one genre serving as the reference category. For interpretability, genres are grouped into the ten most frequent genres, with all remaining categories combined into an “Other” category.

## Method
To answer the research question, we use linear regression analysis. The dependent variable is the average rating and runtime serves as the independent variable. The number of votes is included as a control variable to account for the differences in visibility and popularity across movies. To examine if the relationship between runtime and the average rating is different across genre categories, genre is the moderator. This allows us to evaluate whether the relationship between runtime and the average rating varies depending on genre. 

Linear regression analysis is the most suitable method to answer the research question, because the dependent variable (average rating) and independent variable (runtime) are both continuous. 

## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
  
Preliminary analysis show that the relationship between the average rating and runtime is statistically very weak. The data shows that the correlation between the average rating and runtime is approximately 0.008, which is very close to zero and indicates that movies with a longer runtime do not systematically receive a higher rating. You can also see this in the scatterplot (page 13). The red line has a slight positive trend, but the data points (the small black dots) are very dispersed around the same amount of runtime. This shows unexplained variation between ratings across movies with quite similar runtime. This indicates that runtime alone is not a strong predictor of the average rating of a movie. 
The correlation between the number of votes (log-transformed) and the average rating is approximately -0.08, which indicates a very small negative correlation. This could indicate that movies with a lot of votes tend to receive more critical evaluations, possibly due to the larger audience for reviews. 
As shown in the boxplot (page 15), genre category comparisons have a lot of variations in average ratings. For example, the average rating of the genres biography and documentary are quite higher than the average rating of the genre horror. This indicates that genre may moderate in the relationship between the average rating and runtime. 

- How are the findings/end product of the project deployed?

The findings of the research are presented in a structured R Markdown report. In the R Markdown report, the complete data analysis is documented step by step. This report includes data preparation, statistical analysis and visualizations such as scatter plots and box plots. 
Furthermore, the workflow is completely reproducible. The IMDb data can be downloaded online automatically and analyzed through a script. This allows other researchers to easily replicate the study or extend the analysis using different selection criteria (for example, the research with focus on one specific genre).


- Explain the relevance of these findings/product.

The research findings show that runtime on its own is a very weak predictor of the average rating. This is relevant because it challenges the assumption that longer movies tend to receive higher ratings (Moon et al., 2009). This indicates that runtime is not necessarily a reliable strategy for achieving higher ratings in movies. Moreover, the research shows that genre category comparisons have a lot of variations in average ratings. This means that statements about an ‘ideal movie length’ can generally be misleading, and choices should possibly be approached genre-specific. 

Including the number of votes as a control variable is essential for a more correct interpretation. By controlling for the number of votes in this research, the effect of runtime is estimated with equal visibility, which strenghtens internal validity. 


## Repository Overview 
### Data and Reproducibility
The analysis uses the official IMDb datasets:
- title.basics.tsv.gz
- title.ratings.tsv.gz

These datasets are programmatically downloaded via scripts in the repository to ensure full reproducibility. The datasets are merged using the unique identifier tconst.                  

To ensure a consistent analytical sample:
- The data are restricted to entries where titleType = "movie".
- Observations with missing runtime, rating, or vote counts are removed.
- Because IMDb assigns multiple genres per title, only the first listed genre is used as the primary genre classification to maintain one observation per film.
- Genres are further grouped into the top 10 most frequent categories, with remaining genres combined into an "Other" category.

After cleaning and filtering, the final dataset contains 299,473 unique movie observations.

### Variables
- Dependent variable: averageRating — continuous IMDb user rating (1–10), representing audience evaluation.
- Independent variable: runtimeMinutes — movie runtime in minutes (continuous).
- Control variable: numVotes (log-transformed) — total number of user votes, capturing visibility and popularity and improving robustness against skewness.
- Moderator: genre (main genre, top 10 + Other) — categorical variable used to test whether the runtime–rating relationship differs across genres.

### Repository Structure
The repository is organized to support transparency and reproducibility:
- data/ – scripts for automated data acquisition
- src/data-preparation/ – data cleaning and variable construction
- src/analysis/ – analytical code
- reporting/ – RMarkdown report with data preparation and exploratory analysis
- makefile – pipeline automation

README.md – project documentation

## Dependencies 
This project was developed using:
R (version 4.0 or higher)
RStudio (recommended)

The following R packages are required:
readr
dplyr
tidyr
rmarkdown
knitr

If these packages are not installed, they can be installed using:
install.packages(c("readr", "dplyr", "tidyr", "rmarkdown", "knitr"))

## Running Instructions 
To reproduce the results of this workflow, follow these steps:
- Open the R Markdown file in RStudio.
- Make sure all required packages are installed.
- Click “Knit” to render the document.

The script will automatically:
- Create a data/ folder
- Download the IMDb datasets (title.basics.tsv.gz and title.ratings.tsv.gz)
- Merge the datasets using tconst
- Filter the data to include only movies
- Create a main_genre variable (first listed genre)
- Clean missing values
- Create the log-transformed variable log_votes
- Perform data exploration and generate all tables and plots
No manual data preprocessing is required.


Test
Test 2.0


## About 
This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 1 members: 
- Bente van Brussel: b.j.m.vanbrussel@tilburguniversity.edu
- Niels Deenen: n.deenen@tilburguniversity.edu
- David Lindwer: d.j.lindwer@tilburguniversity.edu
- Demi Verburg: d.verburg@tilburguniveristy.edu
- Marijn van Dooren: m.vandooren@tilburguniversity.edu
