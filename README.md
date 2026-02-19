[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)

# The influence of movie runtime on average IMDb rating

## Motivation
Online ratings of films play an important role in shaping consumer viewing decisions and influencing recommendation systems on streaming platforms. It is therefore relevant to examine which characteristics of audiovisual content are associated with higher audience ratings. One relevant characteristic is runtime. Research by Moon et al. (2009) shows that longer films tend to receive higher ratings on average, possibly because they are perceived by viewers as more valuable and narratively complex. While a longer runtime may contribute to greater narrative depth, prolonged exposure to audiovisual stimuli may, according to the Attention Restoration Theory, also lead to cognitive fatigue and reduced viewer attention (Baumgartner & Kühne, 2024). This could influence how viewers evaluate the quality of a film or television production. The relationship between runtime and ratings is likely to differ by genre, as different genres create distinct expectations regarding narrative pacing, story development, and ideal length.

The research question is therefore formulated as follows: “To what extent does runtime predict the average IMDb rating of films and to what extent is this relationship moderated by genre?”

This research question aligns with the available IMDb datasets and focuses on whether the length of a movie is related to perceived quality, as reflected in average IMDb ratings. In addition, the number of votes may affect the reliability of ratings. A small number of votes can produce more extreme or biased evaluations. Therefore, the number of votes is included as a control variable. The findings of this research are relevant for both consumers interpreting online ratings and platforms that rely on rating-based recommendation algorithms.

## Data
The data used in this study are obtained from the official IMDb datasets, specifically title.basics.tsv.gz and title.ratings.tsv.gz. These datasets are programmatically downloaded within the R script to ensure full reproducibility.The title.basics dataset contains information on content characteristics such as title type, runtime, and genres. The title.ratings dataset includes the average user rating and the number of user votes. The two datasets are merged using the unique identifier tconst.

To ensure a consistent and comparable sample, the analysis is restricted to movies (titleType = "movie"). Titles with missing values for runtime, average rating, or number of votes are removed.

IMDb allows multiple genres per title. To avoid duplicate observations and ensure one observation per film, only the first listed genre is used as the primary genre classification (main genre).

After cleaning and filtering, the final dataset contains 299.335 unique movie observations.

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
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 


## Repository Overview 
This repository contains a complete data analysis pipeline for working with IMDb data. It covers the full workflow: downloading raw datasets, cleaning and merging data, and generating analytical outputs.

team-projects-team-1

├── data

│   ├── download-data.R          
│   ├── imdb.ratings.tsv.gz      
│   ├── imdb.basics.tsv.gz      
│   └── imdb.rds                 
│
├── reporting

│   └── Markdown-file-ratings-basics-imdb.Rmd   
│
├── src

│   └── ...                     
│
├── README.md                    
└── makefile                     


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

## About 
This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 1 members: 
- Bente van Brussel: b.j.m.vanbrussel@tilburguniversity.edu
- Niels Deenen: n.deenen@tilburguniversity.edu
- David Lindwer: d.j.lindwer@tilburguniversity.edu
- Demi Verburg: d.verburg@tilburguniveristy.edu
- Marijn van Dooren: m.vandooren@tilburguniversity.edu
