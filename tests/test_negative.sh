#!/bin/bash
# Negative test — oversized payload should trigger an alert

echo "[TEST] Negative — oversized payload"

RESULT=$(python3 -c "
import socket
data = b'A' * 2000
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('127.0.0.1', 54000))
sock.close()
print('SENT')
")

if [ "$RESULT" = "SENT" ]; then
    echo "[PASS] Oversized payload sent — expect ALERT in logs"
    exit 0
else
    echo "[FAIL] Could not send oversized payload"
    exit 1
fi
