# Extend from the official Jenkins LTS image
ARG TAG=lts
ARG user=jenkins
FROM jenkins/jenkins:${TAG}

# Switch to root user to install dependencies
USER root

# Install required packages and Docker CLI
RUN apt-get update -qq && \
    apt-get install -qqy \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -qq && \
    apt-get -y install docker-ce-cli && \
    groupadd docker && \
    usermod -aG docker ${user}

# Switch back to the Jenkins user
USER ${user}