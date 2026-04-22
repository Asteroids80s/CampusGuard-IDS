#ifndef LOGGER_H
#define LOGGER_H

#define LOG_FILE "/var/log/campusguard/ids_alerts.log"
#define METRICS_FILE "/var/log/campusguard/metrics.json"

void log_alert(const char *src_ip, int pkt_len, const char *reason);
void export_metrics(int total, int alerts);

#endif
