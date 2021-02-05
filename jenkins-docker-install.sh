#!/bin/sh

#jenkins

touch addusers.sh
cat << EOF > addusers.sh
# quietly add a user without password
sudo adduser jenkins --gecos "jenkins jenkins,8989898 ,9900990099,HomePhone" --disabled-password
# set password
echo "jenkins:passoo7#" | sudo chpassw
EOF
#    touch addusers.sh
#cat << EOF > addusers.sh
##!/bin/bash
#sudo addgroup devops
#sudo adduser jenkins --gecos "Jenkins ,2,1990088944" --disabled-password
#echo "jenkins:jenkins" | sudo chpasswd | sudo adduser jenkins devops
#EOF
    sudo chmod +x addusers.sh
    sudo bash -x addusers.sh
    su jenkins
    cd /home/jenkins

#DOKER INSTALL
    sudo apt-get update
    sudo apt-get install \
    apt-transport-https \	
    ca-certificates \	
    curl \	
    gnupg-agent \
    software-properties-common

    curl -fsSL https://get.docker.com -o get-docker.sh

    sudo usermod -aG docker ${USER}
    sudo sh get-docker.sh

# if docker not start than use			
			
	# rm -rf. /var/lib/docker		
	# sudo chmod 666 /var/run/docker.sock		
	# sudo systemctl start docker

#Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose —version

    sudo chmod 666 /var/run/docker.sock
    docker pull jenkins/jenkins:lts
    docker images     #to check the available images
    docker info | grep -I root    #to check the path where docker saving the files
    sudo du -sh /var/lib/docker/   #to check docker

#Jenkins install
    mkdir jenkins-data
    cd jenkins-data
    mkdir jenkins_home

touch docker-compose.yml
cat << EOF > docker-compose.yml
version: ‘3’
services:
jenkins:
container_name: jenkins
image: jenkins/jenkins
ports:
- “8080:8080”
volumes:
- “$PWD/jenkins_home:/var/jenkins_home”
networks:
- net
networks:
net:
EOF

    id     # to check jenkins_home uid
    docker-compose up -d
    docker logs -f jenkins
