# DevSecOps Pipeline

Projekt portfolio pokazujący pełny pipeline CI/CD z elementami bezpieczeństwa (DevSecOps): od kodu, przez testy i skanowanie podatności, po kontrolowane wdrożenie na środowiska dev i prod.

> **Status:** w trakcie budowy. Zrobione: aplikacja, testy, kontener Docker. Następne: CI w GitHub Actions, skany bezpieczeństwa, wdrożenie.

## O projekcie

Sercem projektu nie jest aplikacja, tylko **proces jej dostarczania**. Aplikacja jest celowo prosta, żeby całą uwagę skupić na automatyzacji i bezpieczeństwie.

## Stack

- **Aplikacja:** Python, FastAPI
- **Testy:** pytest
- **Konteneryzacja:** Docker (multi-stage build, użytkownik non-root)
- **CI/CD:** GitHub Actions (w planach)
- **Bezpieczeństwo:** Gitleaks, Trivy, Checkov (w planach)
- **Infrastruktura:** Terraform, AWS (w planach)

## Endpointy

| Endpoint | Opis |
|----------|------|
| `GET /health` | Status aplikacji (healthcheck) |
| `GET /version` | Wersja aplikacji |
| `GET /items` | Przykładowa lista elementów |

## Uruchomienie lokalne

### Testy

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pytest
```

### Serwer deweloperski

```bash
uvicorn app.main:app --reload
```

Aplikacja działa pod `http://127.0.0.1:8000`, a dokumentacja API pod `/docs`.

### Docker

```bash
docker build -t devsecops-app .
docker run -d -p 8000:8000 --name app devsecops-app
curl http://localhost:8000/health
```

## Decyzje projektowe

- **Multi-stage build:** obraz końcowy nie zawiera narzędzi potrzebnych tylko do budowania, więc jest mniejszy.
- **Użytkownik non-root:** proces w kontenerze nie działa jako root, co ogranicza skutki ewentualnego włamania.
- **Kolejność warstw w Dockerfile:** zależności instalowane przed kopiowaniem kodu, dzięki czemu cache działa przy zmianach samego kodu.
- **Przypięte wersje zależności:** powtarzalne buildy i wiarygodne skanowanie podatności.
- **Ochrona gałęzi `main`:** zmiany wchodzą wyłącznie przez Pull Request.

## Plan pipeline'u

1. **CI:** lint i testy na każdy Pull Request
2. **Security:** skan sekretów (Gitleaks), podatności w zależnościach i obrazie (Trivy), skan kodu Terraform (Checkov)
3. **Build:** budowanie obrazu i wysyłka do rejestru, tagowanie wersją
4. **Deploy dev:** automatyczne wdrożenie
5. **Deploy prod:** po ręcznej akceptacji (GitHub Environments), uwierzytelnianie do AWS przez OIDC

## Diagram architektury


## Czego się nauczyłem


