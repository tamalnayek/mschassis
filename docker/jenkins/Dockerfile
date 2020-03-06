FROM jenkins/jenkins:lts
USER root
RUN mkdir /var/lib/apt/lists/partial
RUN apt-get update && apt-get install -y maven

RUN apt-get install software-properties-common -y
RUN apt-get install apt-transport-https
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update -y 
RUN apt-get install -y docker-ce-cli
