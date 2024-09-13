# Build stage
FROM python:3.9-slim-buster AS builder
WORKDIR /app
RUN apt-get update && \
    apt-get install gcc -y --no-install-recommends

COPY requirements.txt .

RUN pip install -r requirements.txt --user --no-cache-dir

# Runtime stage
FROM gcr.io/distroless/python3-debian11

WORKDIR /app
COPY --from=builder /root/.local /home/nonroot/.local
ENV PATH=/home/nonroot/.local/bin:$PATH
ENV PYTHONPATH=/home/nonroot/.local/lib/python3.9/site-packages

COPY main.py .

EXPOSE 5000
CMD ["main.py"]