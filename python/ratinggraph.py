import pylab, csv

def drawGraph(xData,yData) :
	pylab.figure(1)
	pylab.plot(xData,yData)
	pylab.show()

pylab.title('my Rating', fontsize =25)
pylab.xlabel('Year')
pylab.ylabel('Rating')




years =[]
rating =[]

dataFile = open('ratings.csv', "rb")
reader = csv.reader(dataFile)

rownum = 0
for row in reader:
  years.append(row[0])
  rating.append(row[1])

dataFile.close()

print "years" 
print years
print "ratings"
print rating

drawGraph(years, rating)
