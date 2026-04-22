# CampusGuard IDS — Security Invariants

1. Plaintext telemetry payloads are never written to disk.
   Only alert metadata (timestamp, source IP, reason) is logged.

2. The IDS operates in passive monitoring mode only.
   It never injects packets or modifies network traffic.

3. All testing is performed inside an isolated Docker network
   with no external internet access.

4. Attack simulation scripts are restricted to the Docker
   environment and must never be run on live networks.

5. Log files are append-only. No log entry is ever deleted
   or modified by the IDS process.

6. The IDS process runs as a non-root user inside the
   container wherever possible.
