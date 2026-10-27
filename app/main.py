from fastapi import FastAPI

app = FastAPI()

VERSION = "1.0.0"
ITEMS = [{"id": 1, "name": "mochi"}, {"id": 2, "name": "bubble tea"}]


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/version")
def version():
    return {"version": VERSION}


@app.get("/items")
def items():
    return ITEMS
