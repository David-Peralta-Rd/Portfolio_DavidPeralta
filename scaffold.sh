#!/usr/bin/env bash
# Ejecutar desde la raíz del repo: bash scaffold.sh
set -euo pipefail

command -v uv >/dev/null || { echo "Falta uv: https://docs.astral.sh/uv/ (verifica con: uv --version)"; exit 1; }

[ -e .gitignore ] || printf '.DS_Store\n__pycache__/\n*.pyc\n.env\n.venv/\n' > .gitignore
[ -e .gitattributes ] || printf '* text=auto\n*.sh text eol=lf\n*.py text eol=lf\n' > .gitattributes

mkdir -p src/css src/js/render src/data src/assets/img src/scripts docs/adr
[ -e src/assets/img/.gitkeep ] || touch src/assets/img/.gitkeep

# index.html en la raíz (lo exige GitHub Pages) apuntando a src/
[ -e index.html ] || cat > index.html <<'EOF'
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Portfolio_DavidPeralta</title>
  <link rel="stylesheet" href="./src/css/styles.css">
  <link rel="stylesheet" href="./src/css/sections.css">
</head>
<body>
  <main id="app"><p>Cargando…</p></main>
  <script type="module" src="./src/js/main.js"></script>
</body>
</html>
EOF

[ -e src/css/styles.css ] || cat > src/css/styles.css <<'EOF'
/* scaffold: hola mundo; T04 lo reemplaza */
:root {
  --bg: #f5f5f7;
  --text: #1d1d1f;
  --muted: #6e6e73;
  --border: #d2d2d7;
  --radius: 12px;
}
* { box-sizing: border-box; }
body {
  margin: 0;
  background: var(--bg);
  color: var(--text);
  font-family: system-ui, -apple-system, "Segoe UI", sans-serif;
}
EOF

[ -e src/css/sections.css ] || printf '/* scaffold: T12 lo llena */\n' > src/css/sections.css

[ -e src/js/main.js ] || cat > src/js/main.js <<'EOF'
// scaffold: hola mundo; T13 lo reemplaza
const url = new URL('../data/profile.json', import.meta.url);
const app = document.getElementById('app');
try {
  const res = await fetch(url);
  if (!res.ok) throw new Error('HTTP ' + res.status);
  const profile = await res.json();
  const h1 = document.createElement('h1');
  h1.textContent = profile.name;
  app.replaceChildren(h1);
} catch (err) {
  console.error(err);
  app.textContent = 'No se pudieron cargar los datos.';
}
EOF

[ -e src/data/profile.json ] || cat > src/data/profile.json <<'EOF'
{
  "name": "David Peralta",
  "role": "Programador",
  "tagline": "Pendiente: una línea sobre lo que haces.",
  "bio": "Pendiente: 2-3 frases sobre ti.",
  "avatar": null,
  "cv_url": null,
  "sections": {
    "about": "Sobre mí",
    "projects": "Proyectos",
    "skills": "Habilidades",
    "contact": "Contacto"
  },
  "links": [
    { "label": "GitHub", "url": "https://github.com/" }
  ],
  "skill_groups": [
    { "name": "Lenguajes", "items": ["Python"] }
  ]
}
EOF

[ -e src/data/projects.json ] || cat > src/data/projects.json <<'EOF'
{
  "projects": [
    {
      "id": "ejemplo",
      "title": "Proyecto de ejemplo",
      "summary": "Pendiente: qué hace y para quién.",
      "tech": ["Python"],
      "url_repo": null,
      "url_demo": null,
      "image": null,
      "year": 2026,
      "order": 1,
      "featured": false
    }
  ]
}
EOF

# scaffold: servidor local como script de uv (PEP 723).
# El encabezado lo genera `uv init --script`; solo se reemplaza el cuerpo.
if [ ! -e src/scripts/serve.py ]; then
  uv init --script src/scripts/serve.py
  awk '/^# \/\/\//{c++} {print} c==2{exit}' src/scripts/serve.py > src/scripts/.serve_header
  { cat src/scripts/.serve_header; cat <<'EOF'
"""Servidor local de desarrollo (no se usa en GitHub Pages)."""
import http.server
import sys
import webbrowser
from functools import partial
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


class Handler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self) -> None:
        self.send_header("Cache-Control", "no-store")  # los cambios se ven al recargar
        super().end_headers()


def main() -> None:
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8000
    handler = partial(Handler, directory=str(ROOT))
    server = http.server.ThreadingHTTPServer(("127.0.0.1", port), handler)
    url = f"http://localhost:{port}/"
    print(f"Sirviendo {ROOT} en {url} (Ctrl+C para parar)")
    webbrowser.open(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
EOF
  } > src/scripts/serve.py
  rm src/scripts/.serve_header
fi

echo
echo "Listo. Servidor local rápido (desde la raíz):"
echo "  uv run src/scripts/serve.py          # puerto 8000 y abre el navegador"
echo "  uv run src/scripts/serve.py 9000     # otro puerto"
echo "Verificar datos (existe desde la tarea T03):"
echo "  python3 src/scripts/validate_data.py"
echo "Publicar: git push a main y activar Settings > Pages > Deploy from a branch > main /(root)"
