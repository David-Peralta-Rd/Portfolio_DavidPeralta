"""Renderiza el sitio estático en out_dir."""
import shutil
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

from portfolio.content import load_content

HERE = Path(__file__).parent


def render_site(content_path: Path, out_dir: Path) -> None:
    content = load_content(content_path)
    env = Environment(loader=FileSystemLoader(HERE / "templates"), autoescape=True)
    out_dir.mkdir(parents=True, exist_ok=True)
    html = env.get_template("index.html.j2").render(**content)
    (out_dir / "index.html").write_text(html, encoding="utf-8")
    (out_dir / ".nojekyll").touch()
    shutil.copytree(HERE / "static", out_dir / "static", dirs_exist_ok=True)
