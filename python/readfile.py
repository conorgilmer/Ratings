#!/usr/bin/python

import csv


years =[]
ratings =[]

dataFile = open('ratings.csv', "rb")
reader = csv.reader(dataFile)

rownum = 0
for row in reader:
  print row
  years.append(row[0])
  ratings.append(row[1])

dataFile.close()

print "\n years \n"
print years
print "\n ratings \n"
print ratings
