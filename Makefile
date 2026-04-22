CC = gcc
CFLAGS = -Wall -Wextra -Isr c
SRC = src/ids_sniffer.c src/detection.c src/logger.c
BIN = campusguard

.PHONY: all clean up down demo test bootstrap

all: $(BIN)

$(BIN):
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

bootstrap:
	@echo "[CampusGuard] Installing dependencies..."
	@which docker > /dev/null || (echo "Docker not found" && exit 1)
	@which gcc > /dev/null || (echo "GCC not found" && exit 1)
	@echo "[CampusGuard] Bootstrap complete."

up:
	docker-compose up -d --build

down:
	docker-compose down

demo:
	@echo "[CampusGuard] Running demo..."
	docker-compose exec ids bash -c "cd /app && ./run_demo.sh"

test:
	@echo "[CampusGuard] Running tests..."
	bash tests/test_happy.sh
	bash tests/test_negative.sh
	bash tests/test_edge1.sh
	bash tests/test_edge2.sh

clean:
	rm -f $(BIN)
