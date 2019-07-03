"""
@author: gyaneshwar
"""
from GoogleNews import GoogleNews
import twitter
from builtins import str

nData = open("output.txt","w",encoding="utf-8")
dList = []
googlenews = GoogleNews()
ACCESS_TOKEN = '774052117-sXYJjWqwnl7MkvF3HGXamRXw3ZY8j81aFUS5tDG1'
ACCESS_SECRET = 'SmPLPIkp5xxkcuXJJsDylBHmtayAlfN4ipRJVlPxJkiKM'
CONSUMER_KEY = 'kMGAmxIvHZnfRyHhiGIMCmuFN'
CONSUMER_SECRET = '8sudoUdPJTOfgNMdyBc5zYkzf23K4RnPgRRdbe8J02gGAl1v2b'
t = twitter.Api(consumer_key=CONSUMER_KEY,
                consumer_secret=CONSUMER_SECRET,
                access_token_key=ACCESS_TOKEN,
                access_token_secret=ACCESS_SECRET)
news = t.GetTrendsCurrent(exclude=None)
for res in news:
    n = res.AsDict()
    title = str(n["name"])
    nData.write("***** twitter ********\n")
    nData.write(title+"\n")
    if( '#' in title):
       title = title[1:]
    googlenews.search(title)
    nData.write("****** google news ****** \n")
    for line in googlenews.result():
        title = line['title']
        nLink = line['link']
        if(nLink not in dList):
            nData.write(title+":"+"\n")
            nData.write(nLink)
            nData.write("\n\n")
            dList.append(nLink)
nData.close()
    
    


    
    
    
   
    
    
    
    




