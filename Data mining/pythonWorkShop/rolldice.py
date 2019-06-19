# -*- coding: utf-8 -*-
"""
Created on Mon May 27 20:14:14 2019

@author: gyane
"""

from random import randint

def roll(n):
    return randint(0,n)

val = input("enter value for random no:")
print(roll(int(val,2)))