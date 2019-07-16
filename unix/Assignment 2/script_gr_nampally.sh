
#########################################################
#########################################################
#							#
# TEAM							#
# =====							#
#							#
# Gyaneshwar Rao Nampally A00433014			#
# Sachit Jain A00432721					#
# Allen A00432526					#
#							#
# Execution command : . script_gr_nampally.sh 		#
#							#
#							#
# Output:						#
#							#
# out/app.py 						#
# out/serv.html 					#
#							#
#							#
# note: The files app.py and serv.html are saved 	#
# exclusively as the output of the program. 		#
#							#
#########################################################
#########################################################

#!/bin/bash

echo  "====================================================="
echo  "Running Script File"
echo  "====================================================="

try ()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$? #saving the exit state to SAVED_OPT_E
    set +e #setting the environment variable and allow the program to continue irrespective of the error.
}

throw ()
{
    exit $1 #capturing the first parameter to the function and accessing the parameter using $1
}

catch ()
{
    export ex_code=$? #capturing the exit code produced in try block.
    (( $SAVED_OPT_E )) && set +e #allowing the program to proceed irrespective of the error code presented.
    return $ex_code # returning the program with the presented exit code.
}

#garbage collecting function
destroy_function () {
	#destroying the process id's which are running docker.
	ps | grep docker | awk '{ print $1 }' > process_ids # capturing the ID's of the docker processes.

	#looping and killing each process_ids
	while read p; do
	echo "killing process id: $p"
	kill -9 $p #killing the processes of docker.
	done < process_ids

	#removing the docker containers
	docker container ps -a | grep gr_nampally | awk '{ print $1 }' > docker_ids #capturing the ID's of docker containers.
	if [ -f docker_ids ]
	then
		while read docker_id; do
			echo "Stopping docker with hash:$docker_id"
			echo "please wait ... "
			docker container stop $docker_id > /dev/null
			echo "docker with hash:$docker_id has stopped"
			echo "removing docker with hash :$docker_id"
			docker container rm -f $docker_id > /dev/null #removing the docker containers.
		done < docker_ids
	fi
	sleep 3
	cd ~/script
	rm -f out/Dockerfile #removing the 'Dockerfile' image.
	rm -f out/*ids #removing buffers created by the program.
	rm -f *ids #removing buffers created by the program.
	echo "Clean-up success"
}


#Quesion 1
#check if the 'out' folder does exists, if it does, then delete the folder and create afresh.
program () {

	try
	(
	if [ -d out ] # check the folder 'out'
	then
	        echo  "Folder 'out' exist. Removing now"
	        rm -rf out || throw 1  # -r recursively remove the files inside the directory, -f force the deletion operation irrespective of permissions.
	        echo  "Existing Folder 'out' Deleted Successfully \n"
	fi
	echo  "Creating Folder 'out'"
	mkdir ./out #creating the folder out.
	echo  "Folder Created Successfully \n"

#Question 2
#Enter into the 'out' folder.
	echo  "Entering Folder 'out'"
	cd out
	echo  "Inside  Folder 'out'"


#Question 3
#Download Dockerfile and app.py and check if they exists in the local directory.
	echo  "Downloading the 'Dockerfile' and 'app.py' file from 'http://lnx.cs.smu.ca/docker/'"
	(wget -nv lnx.cs.smu.ca/docker/Dockerfile) || throw 1
	(wget -nv lnx.cs.smu.ca/docker/app.py) || throw 1

	if [ -f Dockerfile ] && [ -f app.py ] #verifying the existance of the files.
	then
		echo  "Files were Downloaded Successfully, as seen below: \n"
	else
		echo  "Files not found\n"
		throw 1 #aborting the program if the functions didnt perform properly.
	fi

#Question 4
#Check the 'day' and evaluate if it is odd or even 
#and replace the text 'Hello world' in app.py accordingly.
	echo  "Checking the date and replacing the content in app.py"

	check_DD=$(($(date +%e)%2)) # capturing the present day and performing mathematical function mod 2.

	if [ $check_DD -eq 1 ] #checking if the function is equal to 1 (which determines if it is even or odd)
	then
		(sed -i 's/Hello World!/Today is an odd day/g' app.py) || throw 1 #replacing Hello world with 'Today is an odd day'
	else
		(sed -i 's/Hello World!/Today is an even day/g' app.py) || throw 1 #replacing Hello world with 'Today is an even day'
	fi

#Question 5
	(docker build -t gr_nampally_a2 -q .) || throw 1 #building the docker image with the name 'gr_nampally_a2' 
	#Justification: with docker we can use --name, but instead process id is providing uniqueness for every instance automatically. 
	#we are any how providing a tag for the docker containers gr_nampally_a2
	port=0 #initializing the port variable.
#Question 6
	echo  "Checking for available ports"
	port=$(nc -zv lnx.cs.smu.ca 1999-65000 2>&1 | grep -m 1 refused | awk '{ print $6 }') #checking for the free ports in the range of 1999, 2500
	echo  "Running docker on port: $port"
	(docker run -p $port:80 gr_nampally_a2 &) > /dev/null || throw 1 # proxy the available port on the parent machine to docker 80 port.
#Question 7

docker container ps -a | grep gr_nampally | awk '{ print $1 }' > docker_ids #storing the Docker unique Id's in 'docker_ids' file as buffer.
while read docker_id; do
	docker_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $docker_id) #Capturing the respective docker IP address
	echo "Docker ID: "$docker_id" , IP Address: "$docker_ip
done < docker_ids

#Question 8
	sleep 5
	test_http=$(curl -s -o /dev/null -w "%{http_code}" lnx.cs.smu.ca:$port) #capturing the response header code. if 200 then success, else test case failed.
	echo $test_http
	if [ $test_http -eq "200" ]
	then
		echo  "Website is working"
	else
		echo  "Website cant be reached, terminating the program"
		throw 1 #throwing an exception as the http didnt return 200 response.
	fi

#Question 9
	wget -nv lnx.cs.smu.ca:$port -O serv.html || throw 1

	if [ -f serv.html ]
		then 
		echo  "serv.html downloaded"
	else
		echo  "serv.html download failed, terminating the program"
		throw 1 #throwing an exception as the serv.html was not captured.
	fi

#Question 10 open
	echo "Porting lnx.cs.smu.ca ---> dev.cs.smu.ca on port : $port"
	(ssh -R $port:127.0.0.1:$port gr_nampally@dev.cs.smu.ca "wget -nv 127.0.0.1:$port") || throw 1

	destroy_function # cleaning the container and image of docker.
	echo "Program Success"
	exit 0 # Exiting the program with success code.
	)
	catch || {
		#Question 11
		#checking if all the functions are executed successfully if not garbage collect the local variables.
		echo "Calling garbage collection"
		destroy_function
	}
}

#catching the inturrupt function and cleaning up the docker image and container
catch_ctrlc (){
	echo "Ctrl-C Caught"
	echo "Calling garbage collection"
	destroy_function
	exit 2
}

#registering a trap to listen to ctrl-C
trap "catch_ctrlc" 2

#cleaning up the docker container and image
destroy_function

#Executing the porgram.
program
