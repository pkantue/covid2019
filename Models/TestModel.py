#this is a script to model SEIR model the SEIR dynamics and predict apex of active cases. 

import pandas 
googleSheetId = '1drFy1W0FCryC_yPW_hUDNKBmQAkGJ-JMzKMEi_7E1nE'
worksheetName = 'Confirmed'
URL = 'https://docs.google.com/spreadsheets/d/{0}/gviz/tq?tqx=out:csv&sheet={1}'.format(
	googleSheetId,
	worksheetName
)

Confirmed = pandas.read_csv(URL)
#debug to printout
print(Confirmed) 
