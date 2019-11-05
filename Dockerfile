FROM jenkins/jenkins:2.186

ARG JENKINS_HOME=/var/jenkins_home
ENV JENKINS_HOME $JENKINS_HOME

USER root

RUN apt-get update && apt-get install apt-transport-https -y

RUN curl https://packages.microsoft.com/keys/microsoft.asc |  apt-key add - && \
 curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
 mkdir -p /etc/sqlcmd && \
 apt-get update && \
 ACCEPT_EULA=y \
 apt-get install -y \ 
            msodbcsql17 \
            mssql-tools \
            unixodbc-dev \ 
            ansible \
            dos2unix \
            locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && rm -rf /var/lib/apt/lists/*

COPY files/ansible /etc/ansible
COPY files/Backup /etc/sqlcmd

COPY files/ dest
COPY plugins.txt $JENKINS_HOME/plugins.txt
COPY files/disable-script-security.groovy $JENKINS_HOME/init.groovy.d/disable-script-security.groovy
COPY files/jenkins.sh files/check.sh /usr/local/bin/
ADD jasc/ /opt/jasc/

RUN install-plugins.sh < $JENKINS_HOME/plugins.txt

USER root

ARG DOCKER_GROUP_ID
RUN curl https://get.docker.com | sh \
    && groupmod -g ${DOCKER_GROUP_ID} docker \
    && usermod -aG docker jenkins \
    && chmod +x /usr/local/bin/jenkins.sh /usr/local/bin/check.sh

USER jenkins

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
