#!/bin/awk
# Usage : awk -f ratingmma.awk results.csv > ratingmma.out
# or   cat rating.csv | awk -f ratingmma.awk
# calculate the average Rating Result and my rating change
# 
#
BEGIN {	FS = ","
	mygrade =1650
	change =0
	min=2500i #yeah right!!
	max=700
	print "\nChess Ratings Report"
	printf "\nStart Rating %d\n", mygrade;
	print "\nNo.\tPlayer\tClub\tGrade\tResult\trdiff\tChange\n";
}
{
	
	if ( $4 == 0){
		extra= -16
		extra = extra + (($3-mygrade)/25)
		if ( extra > 0) extra=0;}
	else if ( $4 == 0.5){
		extra= 0
		extra = extra + (($3-mygrade)/25);}
	else if ( $4 == 1){
		extra= 16
		extra = extra + (($3-mygrade)/25)
		if ( extra < 0) extra=0;}
	printf "%s\t%s\t%s\t %d\t%.1f\t%.2f\t%.2f\n" , NR, $1, $2, $3, $4, ($3 -mygrade)/25, extra;
	change=change+extra;
	sum3+=$3;
	sum4+=$4;
	++n
	min = (min>$3)?$3:min
	max=(max>$3)?max:$3
} 
END { 
	printf "\n\tMinimum:\t%d",  min 
	printf "\n\tMaximum:\t%d",  max 
	printf "\n\tAverage:\t%d \t %.2f\tChange\t%.2f\n\n",  sum3/n, sum4/n, change 
	printf "\nNew Rating %d\n\n", mygrade+change;
}
