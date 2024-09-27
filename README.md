# OCA Days 2024 uv Odoo project demo

## Level 1

In this level, we have a very simple `pyproject.toml`, that is
sufficient to run odoo with `uv run odoo`.

The first run, it is slow as `uv` populates its git cache from the huge odoo
repo, but subsequent runs are fast, even when updating Odoo.
