"""Comandos: build y serve."""
from pathlib import Path

from portfolio.render import render_site

ROOT = Path(__file__).parent
OUT = ROOT.parent / "dist"
CONTENT = ROOT / "content.toml"


def build() -> None:
    render_site(CONTENT, OUT)


def serve() -> None:
    from livereload import Server

    build()
    server = Server()
    for pattern in ("templates/**/*", "static/**/*", "content.toml"):
        server.watch(str(ROOT / pattern), build)
    server.serve(root=str(OUT), host="localhost", port=8000)
