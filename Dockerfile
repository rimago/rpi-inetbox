FROM dtcooper/raspberrypi-os:python-bookworm

RUN apt-get update && \
    apt-get dist-upgrade -y 

RUN mkdir /inetbox

ADD ./entry.sh /inetbox

RUN cd /inetbox && \
    python -m venv venv && \
    /inetbox/venv/bin/pip install inetbox_py[truma_service] 

RUN groupadd -g 9003 inetbox && \
    useradd -u 9003 -g inetbox -r -s /sbin/nologin inetbox && \
    usermod -aG dialout inetbox
    
ENTRYPOINT ["/inetbox/entry.sh"]
