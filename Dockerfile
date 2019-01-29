#FROM nginx
FROM centos:7

RUN yum update -y && yum install -y epel-release && yum install -y ansible

#RUN apt-get -y update &&  apt-get -y install php
#RUN yum -y update && yum -y install php



