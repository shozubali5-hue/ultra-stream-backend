# ==================================================================
# ⚡ ULTIMATE QUANTUM AEGIS DOCKER CONTAINER (ENTERPRISE)
# Optimized Multi-Stage Security-Hardened Build (Python 3.12-Slim)
# ==================================================================

# --- STAGE 1: Build Dependencies ---
FROM python:3.12-slim AS builder

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on

WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --prefix=/install --no-warn-script-location -r requirements.txt

# --- STAGE 2: Secure Production Runner ---
FROM python:3.12-slim AS runner

# Security: Create non-root system user
RUN groupadd -r aegis && useradd -r -g aegis aegis

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local
COPY --chown=aegis:aegis . /app

# System Hardening & Permissions
ENV PATH=/usr/local/bin:$PATH \
    PORT=8000 \
    PYTHONUNBUFFERED=1

EXPOSE 8000

USER aegis

# Container Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/api/v1/health || exit 1

# Production WSGI/ASGI Hybrid Engine
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-w", "4", "--bind", "0.0.0.0:8000", "--timeout", "120", "--keep-alive", "5", "main:app"]
