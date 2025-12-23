FROM python:3.11-slim
RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Create non-root user and give ownership of /app
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["python"]
CMD ["main.py"]

