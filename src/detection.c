#include <stdio.h>
#include <string.h>
#include "detection.h"

AlertResult detect_packet(const char *buf, int len, const char *src_ip) {
    AlertResult result;
    result.is_alert = 0;
    memset(result.reason, 0, sizeof(result.reason));

    /* Rule 1 — oversized payload */
    if (len > MAX_PAYLOAD_SIZE) {
        result.is_alert = 1;
        snprintf(result.reason, sizeof(result.reason),
                 "OVERSIZED_PAYLOAD: %d bytes exceeds limit of %d",
                 len, MAX_PAYLOAD_SIZE);
        return result;
    }

    /* Rule 2 — suspicious ASCII pattern */
    if (strstr(buf, ALERT_PATTERN) || strstr(buf, SUSPECT_PATTERN)) {
        result.is_alert = 1;
        snprintf(result.reason, sizeof(result.reason),
                 "SUSPICIOUS_PATTERN: payload contains known malicious string");
        return result;
    }

    /* Rule 3 — unexpected source IP */
    if (strncmp(src_ip, ALLOWED_SUBNET, strlen(ALLOWED_SUBNET)) != 0) {
        result.is_alert = 1;
        snprintf(result.reason, sizeof(result.reason),
                 "UNAUTHORIZED_SOURCE: %s is not in allowed subnet %s",
                 src_ip, ALLOWED_SUBNET);
        return result;
    }

    return result;
}
