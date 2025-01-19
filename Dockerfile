FROM dtcooper/raspberrypi-os:python-bookworm

RUN apt-get update && \
    apt-get dist-upgrade -y 

RUN mkdir /inetbox

ADD ./entry.sh /inetbox

RUN cd /inetbox && \
    python -m venv venv && \
    /inetbox/venv/bin/pip install inetbox_py[truma_service] 
    
ENTRYPOINT ["/inetbox/entry.sh"]
