#!/bash/bin

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

echo -e "Files were Downloaded Successfully, as seen below: \n"
ls

DD=$(date +%d)

check=$($day%2)

echo -e "Current Day: \n"
echo -e $DD

if [ $check -eq 0 ]
then
        echo "Even"
#       sed -i 's/Hello World!/Today is an even day/g' app.py
else
        echo "Odd"
#       sed -i 's/Hello World!/Today is an odd day/g' app.py
if
echo -e "-----------------------------------"
echo -e "-----------------------------------"

cd ..

#docker build -t a_mathew_a2 .
#docker run -p 1122:80 a_mathew_a2

#min_port = 1999

#while [ $min_port -lt 2050 ]
#do
#       echo -e $min_port
#       ((min_port++))
#done

#if [ $? -eq 0 ]
#then
#       echo "Success: I found IP address in file."
#       docker ps -a | grep a_mathew | awk '{ print $1 }'
#       val = (docker ps -a | grep a_mathew | awk '{ print $1 }')
#       echo -e "Printing Result"
#       echo $val
#
#else
#       echo "Failure: I did not found IP address in file. Script failed" >&2
#fi
