c.Spawner.default_url = '/user/{username}/lab'

c.JupyterHub.services = [
    {
        'command': ['/opt/conda/bin/comsoljupyter', 'web', '-p', '12345', '-s', '/srv/jupyterhub', '-d'],
        'name': 'comsol',
        'url': 'http://127.0.0.1:12345',
    },
]
