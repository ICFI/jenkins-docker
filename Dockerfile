FROM jenkins/jenkins:lts

# Install AWS CLI, Docker client and NodeJS
USER root
RUN apt-get update && \
     apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        jq \
        python3-pip \
        software-properties-common \
        sudo && \
     pip3 install awscli && \
     echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
     apt-key adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
     apt-get update && \
     apt-get install -y docker-engine && \
     curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
     apt-get install -y nodejs && \
     rm -rf /var/lib/apt/lists/* && \
     echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]