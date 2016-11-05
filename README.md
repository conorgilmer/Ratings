#Ratings Calculator
Calculate chess ratings after a match or season

*The basic rule used here is that it is +16 points for a win +/- 4points for every 100 differnce between the ratings of the 2 opponents, 0 points for a draw +/- 4pts for every 100 points difference, and -16 for a loss +/-4 for ecery 100 points difference.*

##Awk
The awk version reads in a csv file and calculates the average opponent rating, and results and the rating change after each game
The csv file is constructed as {Opponent, Club, Rating, Result}.
The change in a rating over a season is calculated

##Perl Version
The perl version again accepts in a csv file, with the column names in the first row, and calculates the average rating of an opponent and the grade change from each game andding them up for the total change over a season

##Python 
Take the years and grades from a csv file and plot a line graph
Usage python ratinggraph.py
There is also an anaconda notebook version *ratinggraph.ipynb*

###Python Version Ratings Calculator

###Rating Graph
Plots a line graph from a csv file of ratings over the years, file format is Year, Rating. There is a python script and ananconda notebook version of this

##Java Version
Reads in a csv file calcualtes the rating change over the season from the games in the file, and generates  report object and prints it to the screen.

##Cobol Version
+ CHESSRATING.COB - imports games from a data file processes rating changes and outputs season rating changes
