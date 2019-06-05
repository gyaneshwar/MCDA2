# -*- coding: utf-8 -*-
"""
Created on Mon May 27 19:14:55 2019

@author: gyane
"""

my_list = ["hello",21,4.5,"smu"]
for e in my_list:
    print(e)
    print(type(e))
    if(type(e)==str):
        for st in e:
            print("st:",st)
            
new_list = ["1","2","0"]

my_list.extend(new_list)
for i in my_list:
    print(i)

new_list.sort()
print(new_list)

print(sorted(new_list))