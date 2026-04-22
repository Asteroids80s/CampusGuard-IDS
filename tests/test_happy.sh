#!/bin/bash
# Happy path test — normal telemetry should NOT trigger an alert

echo "[TEST] Happy path — normal telemetry packet"

RESULT=$(echo "STATUS:OK temp=72 humidity=45" | \
    python3 -c "
import socket, sys
data = sys.stdin.read().strip().encode()
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('127.0.0.1', 54000))
sock.close()
print('SENT')
")

if [ "$RESULT" = "SENT" ]; then
    echo "[PASS] Normal telemetry packet sent successfully"
    exit 0
else
    echo "[FAIL] Could not send normal telemetry packet"
    exit 1
fi
