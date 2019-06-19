# -*- coding: utf-8 -*-
"""
Created on Wed May 29 19:09:26 2019

@author: gyane
"""

import numpy as np
#%%
a = np.array([1212,2323,3434])
print(a)

#%%
z = np.zeros([5,10])
print(z)

#%%

ar = np.arange(0,15)
print(ar.shape)
ar = ar.reshape([5,3])
print(ar.shape)
print(ar)

#%%

new_mat = np.random.randint(1,100,[5,5])
print(new_mat)
#%% first row
print(new_mat[0,:])
print(new_mat[0,1:])
#%% first column
print(new_mat[1:,0])
#%%
a = np.floor(10*np.random.random([2,3]))
b = np.floor(10*np.random.random([2,3]))
print(a)
print(b)
print(np.vstack((a,b)))
print(np.hstack((a,b)))