#importing a CSV format file
#csv files - used to store tabulated data
#csv stands for "comma-seperated values"
x=read.csv("data.csv")
x
x=read.csv("data.csv", header = T) #if marked true, first line is will be read as labels, otherwise as a plain text
# abc radio stations data URL
abc = "http://www.abc.net.au/local/data/public/stations/abc-local-radio.csv"
