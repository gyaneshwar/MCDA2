#%matplotlib inline
from matplotlib import pyplot as plt
from PIL import Image
import numpy as np
import os

# read the file
img = Image.open("images/6_original.png")
img_array = np.asarray(img)
print("Image shape: ", img_array.shape)

# extract just the alpha layer
alpha_layer = img_array[:,:,3]

# display the image
plt.imshow(alpha_layer, cmap='gray')

# read all the images and concatenate them
file_list  = os.listdir("images")
filenames = [i for i in file_list if "original" in i]
stacked_image = np.array([])
for i, filename in enumerate(filenames):

    img = Image.open("images/"+filename)
    img_array = np.asarray(img)[:,:,3]
    if i==0:
        stacked_image = img_array
    else:
        stacked_image = np.hstack((stacked_image, img_array))

# show the concatenated
plt.imshow(stacked_image, cmap='gray')
