FROM jupyterhub/jupyterhub:latest
MAINTAINER Pepe Barbe <pepe@radiasoft.net>

RUN apt-get update && \
    apt-get install -y build-essential nginx-full ssl-cert libssl-dev libyaml-dev libffi-dev git htop vim && \
    pip install jupyter jupyterlab && \
    jupyter serverextension enable --py jupyterlab --sys-prefix

WORKDIR /src

ADD .git /src/.git/
ADD pykern /src/pykern/
RUN cd pykern && pip install -r requirements.txt && python setup.py install

ADD comsoljupyter /src/comsoljupyter/
RUN cd comsoljupyter && pip install -r requirements.txt && python setup.py install 

ADD rsjupyter /src/rsjupyter/
RUN cd rsjupyter && python setup.py install && \
    jupyter labextension install --py --sys-prefix rsjupyter && \
    jupyter labextension enable --py --sys-prefix rsjupyter

RUN rm -rf  /src ~/.cache ~/.npm

ADD jupyterlab/jupyterlab/__init__.py /src/jpl__init__.py
RUN mv /src/jpl__init__.py /opt/conda/lib/python3.5/site-packages/jupyterlab/__init__.py

ADD jupyterhub_config.py /srv/jupyterhub/
WORKDIR /srv/jupyterhub/

CMD echo "nameserver 8.8.8.8\nnameserver 8.8.4.4" > /etc/resolv.conf && jupyterhub
