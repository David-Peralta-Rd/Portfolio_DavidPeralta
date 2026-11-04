#!/usr/bin/env bash
# scaffold: crea el esqueleto del portafolio; no sobrescribe nada existente
set -euo pipefail

put() { # put <ruta>: escribe stdin solo si el archivo no existe
  if [ -e "$1" ]; then echo "skip  $1"; cat >/dev/null; return; fi
  mkdir -p "$(dirname "$1")"; cat > "$1"; echo "creó  $1"
}

put .gitignore <<'EOF'
.venv/
__pycache__/
.DS_Store
EOF

put .gitattributes <<'EOF'
*.sh text eol=lf
EOF

mkdir -p src/css src/js src/data src/assets/img src/scripts docs/adr

put index.html <<'EOF'
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>David Peralta — Portafolio</title>
<link rel="stylesheet" href="src/css/base.css">
<link rel="stylesheet" href="src/css/layout.css">
<link rel="stylesheet" href="src/css/components.css">
</head>
<body>
<main id="app">
  <section class="window">
    <div class="window__bar"><span></span><span></span><span></span></div>
    <div class="window__body"><h1 id="name">Cargando…</h1></div>
  </section>
</main>
<noscript>Activa JavaScript para ver el portafolio.</noscript>
<script type="module" src="src/js/main.mjs"></script>
</body>
</html>
EOF

put src/css/base.css <<'EOF'
/* tokens mínimos; se afinan en T02 */
:root { --bg:#fafafa; --fg:#1c1c1e; --border:#d8d8dc; --radius:12px; }
@media (prefers-color-scheme: dark) {
  :root { --bg:#161618; --fg:#f2f2f4; --border:#3a3a3e; }
}
* { box-sizing: border-box; }
body { margin:0; background:var(--bg); color:var(--fg);
  font-family: system-ui, -apple-system, "Segoe UI", sans-serif; line-height:1.5; }
EOF

put src/css/layout.css <<'EOF'
/* contenedor central; la rejilla responsive se hace en T10 */
main { max-width: 960px; margin: 0 auto; padding: clamp(16px, 4vw, 48px); }
EOF

put src/css/components.css <<'EOF'
/* marco tipo mac; se afina en T03 */
.window { border:1px solid var(--border); border-radius:var(--radius); overflow:hidden; }
.window__bar { display:flex; gap:6px; padding:10px 12px; border-bottom:1px solid var(--border); }
.window__bar span { width:10px; height:10px; border-radius:50%; background:var(--border); }
.window__body { padding:16px 20px; }
EOF

put src/js/data.mjs <<'EOF'
// carga un JSON relativo a la raíz del sitio
export async function loadJson(path) {
  const res = await fetch(path);
  if (!res.ok) throw new Error(`${path}: HTTP ${res.status}`);
  return res.json();
}
EOF

put src/js/main.mjs <<'EOF'
// hola mundo: muestra el nombre leído del JSON
import { loadJson } from "./data.mjs";

const el = document.getElementById("name");
try {
  const profile = await loadJson("src/data/profile.json");
  el.textContent = profile.name;
} catch (err) {
  el.textContent = "No se pudo cargar el perfil";
  console.error(err);
}
EOF

put src/data/profile.json <<'EOF'
{
  "name": "David Peralta",
  "role": "Desarrollador de software",
  "tagline": "Construyo cosas simples que funcionan.",
  "about": "Texto de ejemplo; reemplazar en T04.",
  "avatar": null,
  "links": [{ "label": "GitHub", "url": "https://github.com/" }],
  "skills": [{ "group": "Lenguajes", "items": ["Python", "JavaScript"] }]
}
EOF

put src/data/projects.json <<'EOF'
{
  "projects": [
    {
      "id": "proyecto-ejemplo",
      "name": "Proyecto de ejemplo",
      "summary": "Descripción corta; reemplazar en T04.",
      "tags": ["python"],
      "repo_url": "https://github.com/",
      "demo_url": null,
      "order": 1
    }
  ]
}
EOF

for f in render_profile render_skills render_projects; do
  [ -e "src/js/$f.mjs" ] || { : > "src/js/$f.mjs"; echo "creó  src/js/$f.mjs"; }
done
[ -e src/scripts/validate_data.py ] || { : > src/scripts/validate_data.py; echo "creó  src/scripts/validate_data.py"; }
touch src/assets/img/.gitkeep docs/adr/.gitkeep

echo
echo "Servir en local (desde la raíz; fetch no funciona con file://):"
echo "  python3 -m http.server 8000   → http://localhost:8000"
echo "Validar datos:"
echo "  uv run --no-project src/scripts/validate_data.py"
echo "Publicar: push a main y Settings → Pages → Branch: main / (root)"
