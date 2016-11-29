# Comsol + JupyterHub + Docker Integration

## Setup

Build JupyterLab extension:

```sh
cd rsjupydocker/rsjupyter
npm install 
npm run build
```

Build Docker container:

```sh
cd rsjupydocker
docker build -t radiasoft/rsjupydocker .
```

Edit `/etc/hosts` to point `comsol.radiasoft.org` to the local machine (127.0.0.1). 

## Run

Run the container:

```sh
docker run --rm -p 8000:8000 -p 65435-65535:65435-65535 --name jupyterhub radiasoft/rsjupydocker:latest
```

Setup the credentials on the container, manually:

```sh
docker exec -it jupyterhub bash
/opt/conda/bin/comsoljupyter db add-credentials -s /srv/jupyterhub <comsol_user> <password>
useradd -m <jupyterhub_user>
echo " <jupyterhub_user>:<password>" | chpasswd 
```

Visit on your web browser [`http://comsol.radiasoft.org:8000`](http://comsol.radiasoft.org:8000).
