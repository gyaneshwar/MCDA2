#convert column to matrix
import re
def columnarToMatrix(input,output):
	f = open(input,"r")
	w = open(output,"w")
	s = ""
	columns = 8
	count = 0
	for x in f:
		s = s + x.rstrip()
		count = count + 1
		if(count >= columns):
			#append the content into new line
			count = 0
			w.write(s)
			w.write("\n")
			s = ""
		else:
			s = s + " "
	w.close()
	f.close()

columnarToMatrix("15minutes.csv","15minutesmatrix.txt")
columnarToMatrix("day.csv","daymatrix.txt")
columnarToMatrix("hourly.csv","hourlymatrix.txt")