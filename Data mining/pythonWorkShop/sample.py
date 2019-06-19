# -*- coding: utf-8 -*-
"""
Created on Mon May 27 21:33:14 2019

@author: gyane
"""
def ds(a,b):
    return (a - b)**2

def fun(tu,ref):
    min_val = 0
    position = 0
    for i in tu:
        su = 0
        for j in range(0,3):
            su+=ds(i[j],ref[j])
        su = su**1/2
        #print(su)
        if(min_val == 0):
            min_val = su
        if(su < min_val):
            min_val = su
            position = i
    print(position," dist ",ref," dist ", min_val)
tu = [(2,3,4),(1,2,4),(5,6,7),(4,5,6)]
ref = (1,1,1)
fun(tu, ref)