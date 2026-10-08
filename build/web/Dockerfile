# Upstream's Dockerfile (app/Dockerfile) with three changes:
# - the database settings upstream's docker-compose.yml passes as environment are baked in
#   (ENV DB_*), with the database at host `db`;
# - only the top-level requirements are pinned upstream (no lockfile), so pip is upgraded to a
#   release that knows --uploaded-prior-to and resolves every dependency as of the pinned
#   commit's date, which keeps the build reproducible;
# - COPY . . reads app/.
FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1
ENV DB_NAME=vulnerable_bank \
    DB_USER=postgres \
    DB_PASSWORD=postgres \
    DB_HOST=db \
    DB_PORT=5432
ENV PIP_UPLOADED_PRIOR_TO=2026-09-22T21:20:01Z

# Install PostgreSQL client
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir pip==26.0.1
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create necessary directories
RUN mkdir -p static/uploads templates

COPY app/ .

# Ensure uploads directory exists and has proper permissions
RUN chmod 777 static/uploads
RUN chmod +x /app/start.sh

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD python -c "import sys, urllib.request; sys.exit(0) if urllib.request.urlopen('http://127.0.0.1:5000/healthz', timeout=5).getcode() == 200 else sys.exit(1)"

CMD ["./start.sh"]
