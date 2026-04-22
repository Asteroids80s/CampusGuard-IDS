#!/bin/bash
# Edge case 1 — payload containing suspicious pattern

echo "[TEST] Edge case 1 — suspicious ASCII pattern"

RESULT=$(python3 -c "
import socket
data = b'RANDOM_MAL' + b'X' * 100
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('127.0.0.1', 54000))
sock.close()
print('SENT')
")

if [ "$RESULT" = "SENT" ]; then
    echo "[PASS] Suspicious pattern payload sent — expect ALERT in logs"
    exit 0
else
    echo "[FAIL] Could not send suspicious pattern payload"
    exit 1
fi
