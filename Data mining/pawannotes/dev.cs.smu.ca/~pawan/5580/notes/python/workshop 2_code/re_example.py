import re
import matplotlib.pyplot as plt
import csv

with open("apache_log.txt") as f:
    file_contents = f.readlines()

ip_dict = {}
with open("parsed_logs.txt", "w", newline='') as f:
        
    for line in file_contents:
        results = re.findall(r'([0-9.]+)[\s-]+\[(.+)\]', line)
    
        ip = results[0][0]
        ts = results[0][1]
        wr = csv.writer(f)
        wr.writerow([ts, ip])
        if ip in ip_dict:
            ip_dict[ip] = ip_dict[ip] + 1
        else:
            ip_dict[ip] = 1

