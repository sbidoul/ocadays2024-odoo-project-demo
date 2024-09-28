FROM odoo:17 AS base

USER root

RUN apt -y update && apt -y install git && rm -rf /var/lib/apt/lists/*

# install python dependencies in /usr/local
RUN --mount=type=bind,source=./requirements.txt,target=/requirements.txt \
    --mount=type=cache,target=/root/.cache/pip \
   pip install -r /requirements.txt

USER odoo

FROM base AS runtime

COPY ./odoo/addons /mnt/extra-addons
