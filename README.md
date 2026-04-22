# CampusGuard IDS

A lightweight Intrusion Detection System that monitors campus 
device telemetry traffic, detects anomalous packets, and logs 
alerts in real time.

## Quick Start

```bash
make bootstrap
make up && make demo
```

## How It Works

IoT device simulators send UDP telemetry to a central campus 
monitor server. The IDS sniffer passively monitors all traffic 
on port 54000 and applies three detection rules:

1. Oversized payload — flags packets larger than 1024 bytes
2. Suspicious pattern — flags known malicious ASCII strings
3. Unauthorized source — flags IPs outside 192.168.1.0/24

## Project Structure# CampusGuard-IDS
src/           — C source files
tests/         — test scripts and demo
artifacts/     — pcaps, logs, metrics
docs/          — runbook and documentation
.github/       — CI pipeline

## Running Tests

```bash
make test
```

## Architecture

See docs/ for full architecture diagram and runbook.
