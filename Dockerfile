# syntax=docker/dockerfile:1.4

#######################################################################################
# Base stage, with the non-python runtime dependencies, and uv.
#

FROM ghcr.io/acsone/odoo-bedrock:17.0-py312-jammy-latest AS base

# Install apt runtime dependencies.
RUN set -e \
  && apt update \
  && apt -y install --no-install-recommends \
       postgresql-client \
  && apt -y clean \
  && rm -rf /var/lib/apt/lists/*

# Install uv, and configure it for optimal usage in Dockerfile.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
ENV UV_PROJECT_ENVIRONMENT=$VIRTUAL_ENV
ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1

#######################################################################################
# Dependencies stage, where we install tools necessary to build source distributions,
# and install all the locked dependencies in the virtual environment.
#

FROM base AS dependencies

# Install git and other build tools.
RUN set -e \
  && apt update \
  && apt -y install --no-install-recommends \
       git \
       python3.12-dev \
       build-essential \
       libpq-dev \
  && apt -y clean \
  && rm -rf /var/lib/apt/lists/*

# Install the locked dependencies in the virtual environment, but not the project
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project

#######################################################################################
# In this runtime stage, we install the app in editable mode, on top of dependencies.
#

FROM base AS runtime

COPY --from=dependencies $VIRTUAL_ENV $VIRTUAL_ENV

# Install the app
COPY . /app
WORKDIR /app
RUN python -m compileall .
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked
