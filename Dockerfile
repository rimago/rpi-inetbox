FROM dtcooper/raspberrypi-os:python-bookworm

RUN apt-get update && \
    apt-get dist-upgrade -y 

RUN ls

RUN mkdir /inetbox && \
    cd /inetbox && \
    git clone https://github.com/rimago/inetbox.py.git

ADD ./entry.sh /inetbox

RUN cd /inetbox && \
    pip install poetry 

RUN cd /inetbox/inetbox.py && \
    poetry config virtualenvs.create false && \
    poetry build 

RUN cd /inetbox && \
    python -m venv venv && \
    /inetbox/venv/bin/pip install 'inetbox.py/dist/inetbox_py-0.3-py3-none-any.whl[truma_service]'
    
ENTRYPOINT ["/inetbox/entry.sh"]
