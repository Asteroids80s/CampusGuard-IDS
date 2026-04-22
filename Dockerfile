FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    gcc \
    make \
    netcat-openbsd \
    tcpdump \
    python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src/ ./src/
COPY tests/ ./tests/
COPY Makefile .

RUN mkdir -p /var/log/campusguard

RUN make all

COPY tests/run_demo.sh ./run_demo.sh
RUN chmod +x run_demo.sh

CMD ["./campusguard"]
