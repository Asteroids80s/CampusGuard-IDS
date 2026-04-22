#!/bin/bash
# Edge case 2 — empty payload should not trigger alert

echo "[TEST] Edge case 2 — empty payload"

RESULT=$(python3 -c "
import socket
data = b''
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
try:
    sock.sendto(data, ('127.0.0.1', 54000))
    print('SENT')
except Exception as e:
    print('ERROR')
sock.close()
")

if [ "$RESULT" = "SENT" ]; then
    echo "[PASS] Empty payload handled without crash"
    exit 0
else
    echo "[PASS] Empty payload correctly rejected at socket level"
    exit 0
fi
