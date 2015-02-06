#!/usr/bin/python

import csv

totalgrades  = 0
totalresults = 0.0
rating       = 1650
change       = 0
extra        = 0
minR	     = 2500
maxR         = 0

dataFile = open('results.csv', "rb")
reader = csv.reader(dataFile)

print "\n *** Starting *** \n"
print " Chess Rating Rating Calculator \n"
print " Player " + "Wood Pusher"
print " Start Rating " + str(rating) + "\n"

rownum       = 0 #row number
for row in reader:
  rdiff      = 0
  extra      = 0
  if rownum <> 0:
    rdiff = int(row[2]) - rating
    totalgrades = totalgrades + int(row[2]) 
    if minR > int(row[2]):
	minR = int(row[2])
    if maxR < int(row[2]):
	maxR = int(row[2])
    totalresults = totalresults + float(row[3])
    res = float(row[3])
    opp = float(row[2])
    if res == 0:
      extra= -16
      extra = extra + ((opp-rating)/25)
    elif res == 0.5:
      extra= 0
      extra = extra + ((opp-rating)/25)
    elif res == 1:
      extra= 16
      extra = extra + ((opp-rating)/25)
      if extra < 0: 
        extra=0
    else:
      print " Error No Match Result"
    change = change + extra
    print row[0] + "\t" + row[1] + "\t" + row[2] +"\t" +row[3]+ "\t" + str(rdiff) + "\t" + str(extra) 
 
  else:
    print row[0] + "\t" + row[1] + "\t" + row[2] +"\t" +row[3] + "\t Diff\t Change"
  rownum = rownum + 1

games = rownum - 1

dataFile.close()

print "\n Minimum:\t" + str(minR) + "\n"
print " Maximum:\t" + str(maxR) 
print "\n Average:\t" + str(totalgrades/games) + "\t" + str(totalresults/games) +"\tChange:" + str(change) + "\n"
print " Games " + str(games)

print " New Rating " + str(rating + change)

print "\n *** The End *** \n"
