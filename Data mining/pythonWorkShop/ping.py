# -*- coding: utf-8 -*-
"""
Created on Wed May 29 17:37:48 2019

@author: gyane
"""

import os
import re
results = os.popen('ping -n 5 cs.smu.ca')
arr = []
for r in results:
    temp = re.findall(r'TTL\=(\d+)',r)
    if(temp):
        arr.append(temp)
sumx = 0
for r in arr:
    sumx+=int(r[0])
print(sumx/len(arr))
