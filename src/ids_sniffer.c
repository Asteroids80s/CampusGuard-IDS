#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include "detection.h"
#include "logger.h"

#define TELEMETRY_PORT 54000
#define BUFFER_SIZE 65536

int main(void) {
    int sock;
    struct sockaddr_in addr;
    socklen_t addr_len = sizeof(addr);
    char buf[BUFFER_SIZE];

    printf("[CampusGuard] Starting IDS sniffer on port %d...\n", TELEMETRY_PORT);

    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) { perror("socket"); return 1; }

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(TELEMETRY_PORT);

    if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind"); close(sock); return 1;
    }

    printf("[CampusGuard] Listening for telemetry...\n");

    while (1) {
        struct sockaddr_in src;
        socklen_t src_len = sizeof(src);
        int len = recvfrom(sock, buf, BUFFER_SIZE - 1, 0,
                           (struct sockaddr *)&src, &src_len);
        if (len < 0) { perror("recvfrom"); break; }
        buf[len] = '\0';

        char src_ip[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &src.sin_addr, src_ip, sizeof(src_ip));

        printf("[CampusGuard] Packet from %s (%d bytes)\n", src_ip, len);

        AlertResult result = detect_packet(buf, len, src_ip);
        if (result.is_alert) {
            log_alert(src_ip, len, result.reason);
        }
    }

    close(sock);
    return 0;
}
