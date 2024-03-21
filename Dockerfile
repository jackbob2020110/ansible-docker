FROM alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories  && \
    apk --update add sudo                                         && \
    echo "===> Adding Python runtime..."  && \
    apk --update add python3 py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python3-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi -i https://mirrors.aliyun.com/pypi/simple                            && \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apk --update add sshpass openssh-client rsync krb5 krb5-dev && \
    echo "===> Installing Ansible..."  && \
    pip install ansible  -i https://mirrors.aliyun.com/pypi/simple       && \
    echo "===> Installing pip packages ..."  && \
    pip install pywinrm requests-credssp xmltodict kerberos requests_kerberos -i https://mirrors.aliyun.com/pypi/simple&& \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
