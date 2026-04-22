# CampusGuard IDS — Runbook

## Requirements
- Docker Desktop
- GCC
- Python3
- Make

## Fresh Setup

```bash
git clone https://github.com/YOUR_USERNAME/CampusGuard-IDS.git
cd CampusGuard-IDS
make bootstrap
make up && make demo
```

## Rebuilding from Scratch

```bash
make down
make clean
make up && make demo
```

## Viewing Logs

```bash
cat artifacts/release/ids_alerts.log
cat artifacts/release/metrics.json
```

## Stopping the System

```bash
make down
```

## Troubleshooting

Port already in use:
- Run make down to stop all containers
- Run docker ps to check for lingering containers

Docker not found:
- Install Docker Desktop from docker.com
- Make sure it is running before make up
