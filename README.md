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
