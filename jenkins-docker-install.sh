#!/bin/bash
#Update Server
	sudo apt update -y
	sudo apt upgrade -y

#Time and Date update and Network Tools 
	sudo timedatectl set-timezone Asia/Kolkata
	sudo apt install net-tools -y

#jenkins

	touch addusers.sh

cat << EOF > addusers.sh
# quietly add a user without password
sudo adduser jenkins --gecos "jenkins jenkins,8989898 ,9900990099,HomePhone" --disabled-password
# set password
echo "jenkins:passoo7" | sudo chpasswd
EOF

    sudo chmod +x addusers.sh
    bash -x addusers.sh
    sudo rm addusers.sh
    sudo usermod -aG sudo jenkins
    #su jenkins
    #echo 'passoo7' | sudo -S su jenkins

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
    echo 'passoo7' | sudo -S sh get-docker.sh

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
	cd /home/jenkins
    sudo mkdir -p /home/jenkins/jenkins-data/jenkins_home
    cd /home/jenkins/jenkins-data
    sudo mkdir /var/jenkins_home
    sudo chown jenkins:jenkins /var/jenkins_home
    	
	echo 'passoo7' | sudo -S chown -R jenkins:jenkins /home/jenkins/*
	sudo wget https://github.com/pankajthakur888/jenkins/raw/main/docker-compose.yml
	echo 'passoo7' | sudo -S chown jenkins:jenkins docker-compose.yml

    id     # to check jenkins_home uid
    echo 'passoo7' | sudo -S docker-compose up -d
    #docker-compose up -d
    docker logs -f jenkins
