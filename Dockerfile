FROM gliderlabs/alpine:3.4

RUN \
  apk-install \
    curl \
    wget \
    openssh-client \
    python \
    py-boto \
    py-dateutil \
    py-httplib2 \
    py-jinja2 \
    py-paramiko \
    py-pip \
    py-setuptools \
    py-yaml \
    tar && \
  pip install --upgrade pip python-keyczar && \
  rm -rf /var/cache/apk/*

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN \
  curl -fsSL https://releases.ansible.com/ansible/ansible-2.2.2.0.tar.gz -o ansible.tar.gz && \
  tar -xzf ansible.tar.gz -C ansible --strip-components 1 && \
  rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging

RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

RUN mkdir out
COPY playbook.yml .
COPY template.yml .
COPY update.sh .

RUN whoami && pwd && ls -la

#ENTRYPOINT ["ansible-playbook", "playbook.yml"]
RUN which wget
RUN wget --user='admin' --password='admin123' 'http://nexus-nexus.88-160-14-7bdf86.frn00006.cna.ukcloud.com/repository/utils/oc'
RUN chmod +x oc
RUN mv oc /usr/bin/
RUN ls -la /usr/bin
RUN oc version

CMD tail -f /dev/null
#ENTRYPOINT ["update.sh"]
