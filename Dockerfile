FROM odoo:17

USER root

RUN apt -y update && apt -y install git && rm -rf /var/lib/apt/lists/*

# install python dependencies in /usr/local
RUN --mount=type=bind,source=./requirements.in,target=/requirements.in \
    --mount=type=cache,target=/root/.cache/pip \
   pip install -r /requirements.in

USER odoo
