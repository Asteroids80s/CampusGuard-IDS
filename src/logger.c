#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "logger.h"

void log_alert(const char *src_ip, int pkt_len, const char *reason) {
    FILE *f = fopen(LOG_FILE, "a");
    if (!f) {
        /* fallback to stdout if log file not available */
        printf("[ALERT] %s | %d bytes | %s\n", src_ip, pkt_len, reason);
        return;
    }

    time_t now = time(NULL);
    char ts[32];
    strftime(ts, sizeof(ts), "%Y-%m-%d %H:%M:%S", localtime(&now));

    fprintf(f, "[%s] ALERT | src=%s | len=%d | reason=%s\n",
            ts, src_ip, pkt_len, reason);
    fclose(f);

    printf("[ALERT] %s | %d bytes | %s\n", src_ip, pkt_len, reason);
}

void export_metrics(int total, int alerts) {
    FILE *f = fopen(METRICS_FILE, "w");
    if (!f) return;

    fprintf(f, "{\n");
    fprintf(f, "  \"total_packets\": %d,\n", total);
    fprintf(f, "  \"alerts_triggered\": %d,\n", alerts);
    fprintf(f, "  \"clean_packets\": %d\n", total - alerts);
    fprintf(f, "}\n");
    fclose(f);

    printf("[CampusGuard] Metrics exported to %s\n", METRICS_FILE);
}
