#ratingcalc.c
C version of the rating calculator 
reads in from a csv file (results.csv) and calculates the rating change per game
and average over a season.
the file read in needs to be split hence the use of the str_spilt function
compiled with make 
and executed by
> ./ratingcalc


##to do
+ align the numbers so as they are signed etc. and aligned on the right hand side
+ make functions more generic, reduce the number of variables used
+ add min and max ratings and diff
+ add limits - 0 lost for a win 
