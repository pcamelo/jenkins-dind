# Extend from the official Jenkins LTS image
ARG TAG=lts
FROM jenkins/jenkins:${TAG}

ARG user=jenkins

# Switch to root user to install dependencies
USER root

# Install required packages and Docker CLI
RUN apt-get update -qq && \
    apt-get install -qqy ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update -qq && \
    apt-get -y install docker-ce-cli && \
    groupadd docker && \
    usermod -aG docker ${user}

# Switch back to the Jenkins user
USER ${user}