#%matplotlib inline
import numpy as np
import os 

from PIL import Image
import matplotlib.pylab as plt

def img_to_array(filename):

    img = Image.open("images/"+ filename)
    img_array = np.asarray(img)[:, :, 3]
    
    return img_array

filelist = os.listdir('images')
filtered_list = [i for i in filelist if "orig" in i]

#combined_img_array = np.empty()
for i, file in enumerate(filtered_list):
    img_array = img_to_array(file)
    if i == 0:
        combined_img_array = img_array
    else:
        combined_img_array = np.vstack((combined_img_array, 
                                        img_array))
    
    
plt.imshow(combined_img_array, cmap='gray_r')

