# Base image already provides /usr/bin/sqlite3-3.26.0 and /usr/bin/sqlite3-3.39.4
FROM theosotr/sqlite3-reducer

# Python + pip (Ubuntu 24.04 base)
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 python3-pip \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/reducer

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# Copy reducer source
COPY src/ ./src/

# Install entry point at the required path
RUN printf '#!/usr/bin/env bash\nexec python3 /opt/reducer/src/reducer.py "$@"\n' \
        > /usr/bin/reducer \
 && chmod +x /usr/bin/reducer

# Grading harness mounts the benchmarks; do NOT copy them into the image.
