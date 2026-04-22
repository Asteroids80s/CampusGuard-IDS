#ifndef DETECTION_H
#define DETECTION_H

#define MAX_PAYLOAD_SIZE 1024
#define ALERT_PATTERN "RANDOM_MAL"
#define SUSPECT_PATTERN "SUSPECT_OVERSIZED"
#define ALLOWED_SUBNET "192.168.1."

typedef struct {
    int is_alert;
    char reason[256];
} AlertResult;

AlertResult detect_packet(const char *buf, int len, const char *src_ip);

#endif
