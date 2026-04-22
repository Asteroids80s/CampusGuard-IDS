#!/bin/bash
echo "============================================"
echo "  CampusGuard IDS — Live Demo"
echo "============================================"

echo ""
echo "[1] Sending normal telemetry from sensor A..."
echo "STATUS:OK temp=72 humidity=45" | nc -u -w1 192.168.1.100 54000
sleep 1

echo "[2] Sending normal telemetry from sensor B..."
echo "STATUS:OK temp=68 humidity=50" | nc -u -w1 192.168.1.100 54000
sleep 1

echo "[3] Sending oversized attack payload..."
python3 -c "
import socket
data = b'A' * 2000
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('192.168.1.100', 54000))
sock.close()
"
sleep 1

echo "[4] Sending suspicious pattern payload..."
python3 -c "
import socket
data = b'RANDOM_MAL' + b'X' * 500
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('192.168.1.100', 54000))
sock.close()
"
sleep 1

echo "[5] Sending SUSPECT_OVERSIZED payload..."
python3 -c "
import socket
data = b'SUSPECT_OVERSIZED' + b'B' * 500
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(data, ('192.168.1.100', 54000))
sock.close()
"
sleep 1

echo ""
echo "[CampusGuard] Demo complete. Check logs at /var/log/campusguard/"
echo "============================================"
