# Upstream

| | |
| --- | --- |
| Project | Vulnerable Bank |
| Repository | https://github.com/Commando-X/vuln-bank |
| Version | main (no release tags) |
| Commit | 4bb7cd5f46921959f034455e5615782481966177 |
| Licence | MIT |

`build/web/app/` is that commit, unchanged, without its Git history. `build/web/Dockerfile` is
upstream's Dockerfile with the database settings from upstream's `docker-compose.yml` baked in
(`ENV DB_*`) and pip resolving dependencies as of the commit date (2026-09-22), because only the
top-level requirements are pinned. `build/db/Dockerfile` is upstream's `postgres:13` with its
compose environment baked in. To update, replace `build/web/app/` with a newer commit, then
change this table and that date.
