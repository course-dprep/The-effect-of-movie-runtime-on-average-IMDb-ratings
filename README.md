[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)

# The influence of runtime on average IMDb rating

## Motivation
Online ratings of films and TV movies play an important role in shaping consumer viewing decisions and influencing recommendation systems on streaming platforms. It is therefore relevant to examine which characteristics of audiovisual content are associated with higher audience ratings. One relevant characteristic is runtime. Research by Moon et al. (2009) shows that longer films tend to receive higher ratings on average, possibly because they are perceived by viewers as more valuable and narratively complex. While a longer runtime may contribute to greater narrative depth, prolonged exposure to audiovisual stimuli may, according to the Attention Restoration Theory, also lead to cognitive fatigue and reduced viewer attention (Baumgartner & Kühne, 2024). This could influence how viewers evaluate the quality of a film or television production. The relationship between runtime and ratings is likely to differ by genre, as different genres create distinct expectations regarding narrative pacing, story development, and ideal length.

The research question is therefore formulated as follows: “To what extent does runtime predict the average IMDb rating of films and TV movies, and to what extent is this relationship moderated by genre?”

This research question aligns with the available IMDb datasets and focuses on whether the length of a film or TV movie is related to perceived quality, as reflected in average IMDb ratings. In addition, the number of votes may affect the reliability of ratings. A small number of votes can produce more extreme or biased evaluations. Therefore, the number of votes is included as a control variable. The findings of this research are relevant for both consumers interpreting online ratings and platforms that rely on rating-based recommendation algorithms.

## Data

The data sets that will be used are title.basics.tsv.gz and title.ratings.tsv.gz. These sets are obtained via the official site of IMDb and are programmatically downloaded in the R script. The final dataset contains 1.636.745 observations 

### Dependent variable - Rating (averageRating)
The dependent variable is the average IMDb user rating of a film or TV show.
It is measured on a continuous scale from 1 to 10.
This variable captures audience evaluation of the content.

### Independent variable - Runtime (runtimeMinutes)
The independent variable is the runtime of a film or TV show episode.
It is measured in minutes and treated as a continuous variable.
Runtime represents the length of the content.

### Control variable - Number of votes (numVotes)
This control variable measures the total number of IMDb user votes.
It is a count variable and captures the popularity and visibility of a title.
Due to its skewed distribution, it may be log-transformed in the regression analysis.

### Moderator - Genre (genre)
Genre is included as a moderating variable to test whether the relationship between runtime and rating differs across content types.
Genre is a categorical variable and is operationalised using dummy variables, with one genre serving as the reference category.

## Method

To answer the research question, we use linear regression analysis. The dependent variable is the average rating and runtime serves as the independent variable. The number of votes is included as a control variable to account for the differences in visibility and popularity across films and TV movies. To examine if the relationship between runtime and the average rating is different across genre categories, genre is the moderator. This allows us to evaluate whether the relationship between runtime and the average rating varies depending on genre. 

Linear regression analysis is the most suitable method to answer the research question, because the dependent variable (average rating) and independent variable (runtime) are both continuous. 

## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 
This repository contains the workflow for downloading, cleaning, merging, and analyzing IMDB data.

### Repository Structure
team-projects-team-1/
│
├── data/
│ ├── download-data.R
│ ├── imdb.ratings.tsv.gz
│ ├── imdb.basics.tsv.gz
│ └── imdb.rds (merged dataset created during analysis)
│
├── reporting/
│ └── RMarkdown file ratings basics imdb.Rmd
│
├── src/
│ └── (data cleaning and helper scripts)
│
├── README.md
└── makefile

## Dependencies
To run this workflow, the following software and R packages are required:

- R (version 4.0 or higher)
- RStudio (recommended)

Required R packages:

- tidyverse
- dplyr
- ggplot2
- readr
- rmarkdown
- knitr

Install packages using:

```r
install.packages(c("tidyverse", "rmarkdown", "knitr"))

## Running Instructions

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 1 members: 
- Bente van Brussel: b.j.m.vanbrussel@tilburguniversity.edu
- Niels Deenen: n.deenen@tilburguniversity.edu
- David Lindwer: d.j.lindwer@tilburguniversity.edu
- Demi Verburg: d.verburg@tilburguniveristy.edu
- Marijn van Dooren: m.vandooren@tilburguniversity.edu
