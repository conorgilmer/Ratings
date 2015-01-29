#!/usr/bin/perl -w
# rating.pl 
# calculate the rating change over a season
# read in a csv file with [Name, Club, Rating, Result}
# and calculate the grading change

use strict;
use warnings;

sub main 
{
   # input file
   my $filename     = "results.csv";
   my $rating       = 1600;
   my $total_grade  = 0;
   my $total_result = 0;
   my $avg_grade    = 0;
   my $avg_result   = 0;
   my $games        = 0;
   my $extra        = 0;
   my $change       = 0;

   open(INPUT, $filename) or die "Cannot open $filename";

 # Read the header line.
   my $line = <INPUT>;

   print("\n Chess Rating Result Calculator\n");  
   print("\n Rating = $rating\n");  
   # Display the header spaced by tabs
   chomp($line);
   my ($hname, $hclub, $hgrade, $hresult) = split(',', $line);
   print("\n$hname\t $hclub\t $hgrade\t $hresult\tChange\n");

   #Read the lines one by one.
   while($line = <INPUT>)
   {
	chomp($line);
	my ($name, $club, $grade, $result) = split(',', $line);
	
	if ( $result == 0){
                $extra= -16;
                $extra = $extra + (($grade-$rating)/25);}
        elsif ( $result == 0.5){
                $extra= 0;
                $extra = $extra + (($grade-$rating)/25);}
        elsif ( $result == 1){
                $extra= 16;
                $extra = $extra + (($grade-$rating)/25);
                if ( $extra < 0){ 
			$extra=0;
		}
	}

	

	# display the line separated into tabs
	print("$name\t $club\t $grade \t $result\t$extra \n");
	$change = $change + $extra;
	$total_grade = $total_grade + $grade;
	$total_result = $total_result + $result;
	$games = $games +1;
  }
  
  $avg_grade = $total_grade / $games;
  $avg_result = $total_result / $games;

  print("\t Avg\t  $avg_grade \t $avg_result\t $change\n");
  $rating = $rating + $change;
  print("\n New Rating = $rating\n");  
  close(INPUT);
}

main();
