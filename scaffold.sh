#!/usr/bin/env bash
set -euo pipefail
# Ejecutar desde la raíz del repo (con git y plantillas ya creados).

[ -e .gitignore ] || cat > .gitignore <<'EOF'
.venv/
__pycache__/
*.pyc
.pytest_cache/
.ruff_cache/
.mypy_cache/
*.egg-info/
src/site/dist/
.env
EOF
[ -e .gitattributes ] || printf '* text=auto\n*.sh text eol=lf\n' > .gitattributes

mkdir -p docs/reference docs/adr .github/workflows src/site
cd src/site

# Generadores de uv
[ -e pyproject.toml ] || uv init --bare --package --build-backend hatch --name portfolio
[ -e .python-version ] || uv python pin 3.15.2

# scaffold: comandos en [project.scripts]
grep -q '^\[project.scripts\]' pyproject.toml || printf '\n[project.scripts]\n' >> pyproject.toml
sed -i '/^portfolio = /d' pyproject.toml
grep -q '^build = ' pyproject.toml || sed -i '/^\[project.scripts\]/a build = "portfolio.cli:build"' pyproject.toml
grep -q '^serve = ' pyproject.toml || sed -i '/^\[project.scripts\]/a serve = "portfolio.cli:serve"' pyproject.toml

# scaffold: hatch, uv, pytest y mypy
grep -q '^# scaffold' pyproject.toml || cat >> pyproject.toml <<'EOF'

# scaffold
[tool.hatch.build.targets.wheel]
packages = ["portfolio"]

# scaffold
[tool.uv]
prerelease = "disallow"

# scaffold
[tool.pytest.ini_options]
testpaths = ["tests"]

# scaffold
[tool.mypy]
ignore_missing_imports = true
EOF

# Carpetas sin generador
mkdir -p portfolio/templates portfolio/static tests
[ -e portfolio/__init__.py ] || touch portfolio/__init__.py
[ -e portfolio/static/.gitkeep ] || touch portfolio/static/.gitkeep

# Dependencias: un solo uv add por grupo, sin pin
uv add jinja2 livereload
uv add --dev pytest ruff mypy
uv lock

[ -e portfolio/cli.py ] || cat > portfolio/cli.py <<'EOF'
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
EOF

[ -e portfolio/render.py ] || cat > portfolio/render.py <<'EOF'
"""Renderiza el sitio estático en out_dir."""
import shutil
import tomllib
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

HERE = Path(__file__).parent


def render_site(content_path: Path, out_dir: Path) -> None:
    content = tomllib.loads(content_path.read_text(encoding="utf-8"))
    env = Environment(loader=FileSystemLoader(HERE / "templates"), autoescape=True)
    out_dir.mkdir(parents=True, exist_ok=True)
    html = env.get_template("index.html.j2").render(**content)
    (out_dir / "index.html").write_text(html, encoding="utf-8")
    (out_dir / ".nojekyll").touch()
    shutil.copytree(HERE / "static", out_dir / "static", dirs_exist_ok=True)
EOF

[ -e portfolio/templates/index.html.j2 ] || cat > portfolio/templates/index.html.j2 <<'EOF'
<!doctype html>
<html lang="es"><head><meta charset="utf-8"><title>{{ profile.name }}</title></head>
<body><h1>{{ profile.name }}</h1><p>Hola mundo</p></body></html>
EOF

[ -e portfolio/content.toml ] || cat > portfolio/content.toml <<'EOF'
[profile]
name = "David Peralta"
EOF

echo
echo "Listo. Verifica la instalación:"
echo "  cd src/site && uv run build && test -f dist/index.html && echo OK"
echo "Desarrollo con recarga en vivo (http://localhost:8000):"
echo "  cd src/site && uv run serve"
echo "Comprobar la recarga en otra terminal:"
echo "  curl -sf http://localhost:8000/ | grep -q livereload && echo OK"
