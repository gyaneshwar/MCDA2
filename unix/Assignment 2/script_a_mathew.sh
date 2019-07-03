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

sed -i 's/Hello World!/Today is an odd day/g' app.py

echo -e "-----------------------------------"
echo -e "-----------------------------------"

docker build -t a_mathew_a2 .
docker run -p 1122:80 a_mathew_a2