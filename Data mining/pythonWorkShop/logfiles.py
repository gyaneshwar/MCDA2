# -*- coding: utf-8 -*-
"""
Created on Wed May 29 18:22:01 2019

@author: gyane
"""

#apache IP and time stamp regular expression.
import csv
import re
result = []
with open("apache_log.txt","r",newline="") as f:
    for r in f:
        result.append(re.findall(r'((\d+\.?){4})[\s\-]{5}\[(.+)\]',r))

with open("clean.csv","w") as f:
    csv_writer = csv.writer(f)
    for j in result:
        csv_writer.writerow([j[0][0],j[0][2]])