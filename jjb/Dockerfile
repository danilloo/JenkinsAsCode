FROM python:3

WORKDIR /opt
RUN git clone https://opendev.org/jjb/jenkins-job-builder.git && \
    cd /opt/jenkins-job-builder && \
    pip install -r test-requirements.txt -e . && \
    mkdir -p /etc/jenkins_jobs/

ARG JENKINS_USER
ARG JENKINS_PWD
ARG JENKINS_URL
RUN echo "[job_builder]\n\
allow_duplicates=True\n\
\n\
[jenkins]\n\
user=$JENKINS_USER\n\
password=$JENKINS_PWD\n\
url=http://$JENKINS_URL\n"\
>> /etc/jenkins_jobs/jenkins_jobs.ini

WORKDIR /opt/jenkins-job-builder
CMD ["sh", "-c"]
