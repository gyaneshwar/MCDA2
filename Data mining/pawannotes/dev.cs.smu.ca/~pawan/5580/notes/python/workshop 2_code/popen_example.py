import os
import re


results = os.popen("ping -n 5 cs.smu.ca").read()
# %% 
re_results = re.findall('Average\s\=\s(\d+)', results)

print("Average time is: ", re_results)

# %% 
print("test")