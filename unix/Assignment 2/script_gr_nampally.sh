#!/bin/bash

echo -e "====================================================="
echo -e "Running Script File"
echo -e "=====================================================\n"

#Quesion 1
if [ -d out ]
then
        echo -e "Folder 'out' exist. Removing now"
        rm -rf out
        echo -e "Existing Folder 'out' Deleted Successfully \n"
fi


echo -e "Creating Folder 'out'"
mkdir ./out
echo -e "Folder Created Successfully \n"

#Question 2
echo -e "Entering Folder 'out'"
cd out
echo -e "Inside  Folder 'out'"

#Question 3
echo -e "Downloading the 'Dockerfile' and 'app.py' file from 'http://lnx.cs.smu.ca/docker/'"
wget lnx.cs.smu.ca/docker/Dockerfile
wget lnx.cs.smu.ca/docker/app.py

if [ -f Dockerfile ] && [ -f app.py ]
then
	echo -e "Files were Downloaded Successfully, as seen below: \n"
else
	echo -e "Files not found\n"
fi

#Question 4
echo -e "Checking the date and replacing the content in app.py"

check_DD=$(($(date +%e)%2))

if [ $check_DD -eq 1 ]
then
	sed -i 's/Hello World!/Today is an odd day/g' app.py
else
	sed -i 's/Hello World!/Today is an even day/g' app.py
fi

#Question 5
docker build -t gr_nampally_a2 .
#Question 6
echo -e "Checking for available ports"
port=$(nc -zv lnx.cs.smu.ca 1999-2500 2>&1 | grep -m 1 refused | awk '{ print $6 }')
echo -e port
echo -e "Running docker on "$port

docker run -p $port:80 gr_nampally_a2 &
#Question 7
docker_id = $(docker container ps -a | grep gr_nampally_a1 | awk '{ print $1 }')
docker inspect --format '{{ .NetworkSettings.IPAddress }}' $docker_id

#Question 8
test_http = $(curl -s -o /dev/null -w "%{http_code}" lnx.cs.smu.ca:$port)

if [ test_http -eq 200 ]
then
echo -e "Website is working"
else
echo -e "Website cant be reached, terminating the program"
destroy_function
fi

#Question 9
wget lnx.cs.smu.ca:$port -O serv.html

if [ -f serv.html ]
then 
echo -e "serv.html downloaded"
else
echo -e "serv.html download failed, terminating the program"
destroy_function
fi

#Question 11
if [ $? -eq 0 ]
then
echo "Success"
destroy_function
else
echo "error has occured"
destroy_function
if

destroy_function () {
#destroying the process id's
ps | grep docker | awk '{ print $1 }' > process_ids

#looping and killing each process_ids
while read p; do
echo "$p"
kill -9 $p
done < process_ids

#removing the process_ids temp file
rm process_ids

cd ..
}





































