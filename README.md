# Installing OCA addons the easy way, 2024 edition

## Level 1

In this project, based on the Odoo 17 official docker image and
docker compose example you can observe...

How to install an OCA addon in the official Odoo docker image (in `requirements.in`).

This project can be started with `docker compose up` then connecting your browser
to `http://localhost:8069`.

It is interesting to note that the Odoo addons path that is shown on Odoo startup has the following components:
- `/usr/lib/python3/dist-packages/odoo/addons`: pre-installed standard Odoo addons in the base docker image
- `/usr/local/lib/python3.10/dist-packages/odoo/addons`: addons added with pip install using the `root` user
- `/var/lib/odoo/addons/17.0`: addons in Odoo's data dir
- `/mnt/extra-addons`: addons that can be mounted (from `/etc/odoo/odoo.conf`),
  as described in the official Odoo docker image documentation.

# Level 2

In this level, we add a devcontainer configuration.

This configuration was added using the Visual Studio Code wizard, using the
`docker-compose.yml` mode, then adding the python vscode extension in
`devcontainer.json`, doing some minor tweaks.

# Level 3

In this level, we add custom addons, in the `odoo/addons` directory.

We also add a runtime layer that adds these addons to `/mnt/addons`,
and update the devcontainer configuration to user the base layer,
since in development mode, our custom addons are mounted in the workspace.

Notice it is not necessary to change the addons path, when launching odoo with
`python3 -m odoo` from the workspace root, because python inserts the local
directory in sys.path, so the `odoo/addons` directory in the workspace is picked
up automatically.
