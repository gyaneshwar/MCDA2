# -*- coding: utf-8 -*-
"""
Created on Wed May 29 19:34:53 2019

@author: gyane
"""

from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

img = Image.open("images\\0_original.png")
img_array = np.array(img)
plt.imshow(img_array)
#%%
alpha_layer = img_array[:,:,3]
plt.imshow(alpha_layer, cmap="gray_r")

#%% read second image

img2 = Image.open("images\\1_original.png")
img_array2 = np.array(img2)
plt.imshow(img_array2)

#%%
alpha_layer2 = img_array2[:,:,3]
plt.imshow(alpha_layer2, cmap="gray_r")

#%%

arr = np.vstack((alpha_layer,alpha_layer2,alpha_layer2))
plt.imshow(arr,cmap="gray_r")

#%% overlap using bitwise_and
overlap = np.bitwise_and(alpha_layer,alpha_layer2)
plt.imshow(overlap, cmap="gray_r")

#%% overlap using cross multiplication.
overlap2 = alpha_layer * alpha_layer2 > 0
plt.imshow(overlap2,cmap="gray_r")

#%% read files from the directory
files = []
for r, d, f in os.walk("images\\"):
    for file in f:
        if 'resized' in file:
            print("images\\"+file)
            imp = Image.open("images\\"+file)
            imp_array = np.array(imp)
            imp_layer = imp_array[:,:,3]
            files.append(imp_layer)
result_vstack = np.vstack(tuple(files))
plt.imshow(result_vstack,cmap="gray_r")
#%%
result_hstack = np.hstack(tuple(files))
plt.imshow(result_hstack,cmap="gray_r")    
#%%
imgimg = Image.open("images\\1_resized.png")
imim = np.array(imgimg)
plt.imshow(imim,cmap="gray_r")