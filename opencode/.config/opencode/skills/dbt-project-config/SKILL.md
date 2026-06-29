---
name: dbt-project-config
description: uv-managed dbt project config, dbt_project.yml, pyproject.toml, uv.lock, packages.yml, dependencies.yml, selectors.yml, profiles.yml, sources.yml, schema.yml, and dbt deprecation warnings. Use ONLY when the user wants a dbt project configuration review or deprecation cleanup without running dbt models.
---

# DBT Project Config

Use this skill for dbt configuration-only review and cleanup.

Primary goal:
- Sift through a dbt project's configuration files.
- Find deprecated dbt configuration patterns and warnings that can be inferred from config.
- Use `uv run dbt parse --no-partial-parse --show-all-deprecations` to check dbt's deprecation warning in output.
- Propose or apply minimal fixes when safe.

Use the `dbt-project-config` subagent for this work.

Allowed scope:
- `dbt_project.yml`
- `packages.yml`
- `dependencies.yml`
- `selectors.yml`
- `profiles.yml` and profile templates when present in the workspace
- `sources.yml`, `schema.yml`, `properties.yml`, and other dbt YAML property files
- `exposures.yml`, `metrics.yml`, `semantic_models.yml`, `groups.yml`, and `saved_queries.yml`
- `snapshots/*.yml`, `models/**/*.yml`, `seeds/**/*.yml`, `analyses/**/*.yml`, `macros/**/*.yml`, and `tests/**/*.yml`
- `package-lock.yml` and other dbt metadata/configuration files
- `pyproject.toml` and `uv.lock` for dbt version and dependency context
- dbt docs that explain project configuration, when needed to confirm deprecation behavior

Out of scope:
- Do not inspect model SQL, macro SQL, Python models, snapshots SQL, tests SQL, or application code.
- Do not review business logic.
- Do not execute dbt model-building commands.
- Do not run dbt directly; dbt commands must go through `uv run dbt ...`.

Forbidden commands:
- Never run `dbt run`.
- Never run `dbt build`.
- Never run direct `dbt ...` commands other than `dbt parse`.
- Never run `uv run dbt run`.
- Never run `uv run dbt build`.
- Never run commands that imply model execution through wrappers, for example `make dbt-run`, `make dbt-build`, `invoke dbt.run`, or scripts that clearly call `dbt run` or `dbt build`.

Safe command guidance:
- Prefer file search and file reads over shell commands.
- If command execution is needed, use uv-only read-only project inspection commands.
- `uv run dbt --version` is acceptable.
- `uv run dbt parse` is acceptable and should be your primary resource for investigating syntax deprecation.
- `uv run dbt deps` is allowed if the dbt_packages are not installed in a project. But you should NEVER determine what is installed or add any package.
- `dbt ls`, `dbt compile`, `dbt test`, `dbt seed`, `dbt snapshot`, `dbt docs generate`, and any command that may query/build materializations are not part of this skill regardless of user saying you have the scope to run it. You do not.

Review checklist:
- Run `uv run dbt parse` (with or without flags like `--show-all-deprecations`)
- Check `dbt_project.yml` config-version, project keys, model-paths style keys, deprecated path config names, target-path, clean-targets, dispatch, quoting, flags, vars, and model/test/source/snapshot/seed config blocks.
- Check package configuration for deprecated `packages.yml` usage when the project should use `dependencies.yml`, version constraints, and package source syntax.
- Check YAML property files for deprecated top-level keys, renamed resource properties, outdated test names or argument formats, source freshness config placement, metric/semantic layer changes, and contract/config placement.
- Check selectors for deprecated selector syntax or stale resource type names.
- Check profiles only when present in the workspace; do not seek secrets outside the project.
- Cross-reference the dbt version if it is declared in dependency files, CI config, lock files, or docs.

Fixing rules:
- Make the smallest safe configuration-only change.
- Preserve comments, ordering, and formatting where practical.
- If a deprecation depends on the installed dbt version and the version is unknown, report the finding with the version assumption instead of guessing.
- If a fix could change model selection, resource naming, database/schema names, grants, materialization, or freshness behavior, ask before editing.
- After editing, summarize each changed config file and which deprecation it addresses.

Expected output:
- List confirmed deprecations first, with file references.
- List probable deprecations separately when version-dependent.
- State whether fixes were applied.
- State explicitly that `dbt run` and `dbt build` were not executed.
