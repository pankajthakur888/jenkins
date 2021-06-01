# jenkins
jenkins run ubuntu 20.04LTS

sudo curl -s https://raw.githubusercontent.com/pankajthakur888/jenkins/main/jenkins-docker-install.sh | bash -x




#https://jimkang.medium.com/how-to-start-a-new-jenkins-container-and-update-jenkins-with-docker-cf628aa495e9

To New Jenkins Container And Update Jenkins (Docker)

let me keep it short, since you’re super busy with your daily tasks. Assuming you’ve logged into your server with bash
Create a directory that will hold your jenkins content (in host)

# I'll keep it as "jenkins", you can use "jenkins_home" if you wish
mkdir -p $HOME/jenkins


2. Start your jenkins image

# if you're using other names, replace $HOME/jenkins with your choice
# in case you want to change port, use this
# -e JENKINS_OPTS="--httpPort=80" (remember to change 8080:8080 below to 80:80)
docker container run \
--name jenkins \
-p 8080:8080 -p 50000:50000 \
-v $HOME/jenkins:/var/jenkins_home \
-d \
jenkins


3. Write down the password you see on your screen



5. Open your browser and access http://YOUR-SERVER-IP:8080 and follow the steps

How To Update Jenkins

1. Right click on the download link and “copy link address”



2. Log in into jenkins container
#using host's root with -u 0
docker container exec -u 0 -it jenkins bash



3. Download the update with the address you copied in step 1
# inside the container, using 2.89.2 as example
wget http://updates.jenkins-ci.org/download/war/2.89.2/jenkins.war



4. Move it to the correct place
mv ./jenkins.war /usr/share/jenkins
5. Change permission (thanks 
Buvanesh Kumar
)
chown jenkins:jenkins /usr/share/jenkins/jenkins.war (updated)



6. Exit container and restart the container
# exit contaienr (inside container)
exit
# restart container (from your server)
docker container restart jenkins
In case if you see a deprecated protocols: JNLP-connect, JNLP2-connect warning, here’s what you can do


Go on, leave here and enjoy life!





