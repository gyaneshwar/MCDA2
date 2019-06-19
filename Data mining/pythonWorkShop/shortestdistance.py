# -*- coding: utf-8 -*-
"""
Created on Mon May 27 19:27:58 2019

@author: gyane
"""


def ds(a,b):
    return (a - b)**2

def cal_dist(tu,ref):
    position = ()
    min_distance = 0
    for i in tu:
        result_distance= 0
        for j in range(0,3):
            result_distance += ds(i[j],ref[j])
        result_distance = result_distance ** 1/2
        if(result_distance < min_distance or min_distance == 0):
            min_distance = result_distance
            position = i
    print(position,"is nearest to",ref," where the distance is ",min_distance)            
            

tu = [(2,3,4),(1,2,4),(5,6,7),(4,5,6)]
    
ref = (3,4,5)

cal_dist(tu,ref)
'''
ref[0]

fd = []


print(fd)'''