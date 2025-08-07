FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080

# Use Gunicorn for production
CMD ["gunicorn", "--workers=4", "--bind=0.0.0.0:8080", "--access-logfile=-", "--error-logfile=-", "app:app"]