# CampusGuard IDS — What Works / What's Next

## What Works

- Raw socket UDP listener on port 54000
- Three detection rules implemented and tested:
  - Oversized payload detection
  - Suspicious ASCII pattern matching
  - Unauthorized source IP detection
- Timestamped alert logging to ids_alerts.log
- JSON metrics export
- Docker environment with two sensor simulators
- Four test scripts covering happy path, negative, and edge cases
- CI pipeline building and running all tests on push

## What's Next

- Capture a full PCAP of the demo traffic using tcpdump
  inside the Docker container for the artifacts folder
- Add TCP packet support alongside existing UDP detection
- Generate initial charts showing detection rate and
  false positive rate from synthetic test runs
- Complete the draft results section with measurements
- Record the demo video showing the full vertical slice
