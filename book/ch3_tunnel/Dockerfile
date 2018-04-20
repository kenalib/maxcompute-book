# c.f. https://docs.docker.com/engine/examples/running_ssh_service/
FROM ubuntu:16.04 as eg_sshd

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


# setup test server
FROM eg_sshd
RUN apt-get install -y default-jre
RUN apt-get install -y python
RUN apt-get install -y vim

RUN mkdir /var/log/nginx
COPY resources/access.log.20140212.gz /var/log/nginx/
