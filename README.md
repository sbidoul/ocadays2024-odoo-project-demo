# OCA Days 2024 uv Odoo project demo

## Level 1

In this level, we have a very simple `pyproject.toml`, that is
sufficient to run odoo with `uv run odoo`.

The first run, it is slow as `uv` populates its git cache from the huge odoo
repo, but subsequent runs are fast, even when updating Odoo.
The first run is slow it `uv` populates it's git cache from the huge odoo repo,
but subsequent runs are fast, even when updating Odoo.

## Level 2

In this level, we just commit the `uv.lock` file that was generated
with `uv run odoo`, or `uv sync` or `uv lock`.

## Level 3

In this level, we add an OCA addon to the project dependencies in
`pyproject.toml`. This is simple and does not require additional tooling. The
downside is that dependencies must be synchronized between `pyproject.toml` and
addons manifests.

## Level 4

In this level, `pyproject.toml` uses
[hatch-odoo](https://github.com/acsone/hatch-odoo/) to collect dependencies
dynamically from the `depends` sections of Odoo addons manifests.
