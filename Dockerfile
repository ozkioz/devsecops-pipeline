# ETAP 1: builder - instaluje zależności
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ETAP 2: obraz końcowy - mały, bez narzędzi do budowania
FROM python:3.12-slim
WORKDIR /app

# kopiujemy tylko zainstalowane zależności z etapu 1
COPY --from=builder /install /usr/local

# kopiujemy kod aplikacji
COPY app/ ./app/

# tworzymy zwykłego użytkownika i przełączamy się na niego (bezpieczeństwo)
RUN useradd -m appuser
USER appuser

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
