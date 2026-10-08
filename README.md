# Vulnerable Bank

[Vulnerable Bank](https://github.com/Commando-X/vuln-bank) by Al-Amir Badmus (Commando-X): a
deliberately vulnerable banking application with web, REST API, GraphQL and AI chat
vulnerabilities. This repository runs it with [Isoloom](https://www.isoloom.com):
[`isoloom.yml`](isoloom.yml) describes the machines, and the upstream source in
[`build/web/app/`](build/web/app) builds with its own Dockerfile (database host and dependency
date baked in).

| Machine | Service |
| --- | --- |
| web | Vulnerable Bank (Flask) on port 5000, API docs at `/api/docs/` |
| db | PostgreSQL 13 on port 5432 |

Not included from upstream's compose file: `xss-cleaner`, which wipes stored XSS payloads after
15 minutes for shared public instances, and `autoheal`, which needs the host's Docker socket.
The AI chat runs in upstream's demo mode: it calls DeepSeek only when a `DEEPSEEK_API_KEY` is
set, and the lab sets none (the network has no internet access).

## Run it

```bash
isoloom generate
isoloom up docker
```

Then open http://localhost:5000/. The same spec runs as Docker on a local VM (`docker-vm`), on a
cloud VM (`cloud-docker`) or on Kubernetes. Lab guide: the vulnerability list in
[upstream's README](https://github.com/Commando-X/vuln-bank#readme).

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as Vulnerable Bank ([LICENSE](LICENSE)). This application is deliberately vulnerable: keep
it isolated.
