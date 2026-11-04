# Portfolio_DavidPeralta

Portafolio para programadores.

## Estructura de carpetas.
```text
Portfolio_DavidPeralta/
├── index.html                 # Página real; referencia src/css, src/js y src/data
├── AGENTS.md  CLAUDE.md  SPEC.md  tasks.md  README.md
├── .gitignore  .gitattributes
├── scaffold.sh                # Crea todo lo de abajo
├── docs/
│   ├── DATA_MODEL.md          # Esquema de los JSON
│   └── adr/                   # Decisiones
└── src/
    ├── css/
    │   ├── base.css           # Tokens (colores, radio, fuente) y reset
    │   ├── layout.css         # Rejilla y media queries (móvil primero)
    │   └── components.css     # .window (marco tipo mac), .tag, botones
    ├── js/
    │   ├── main.mjs           # Orquesta: carga datos y llama a los render
    │   ├── data.mjs           # loadJson(path): fetch + validación de respuesta
    │   ├── render_profile.mjs # renderProfile(profile, root)
    │   ├── render_skills.mjs  # renderSkills(skills, root)
    │   └── render_projects.mjs# renderProjects(projects, root)
    ├── data/
    │   ├── profile.json       # Contenido: perfil, links, habilidades
    │   └── projects.json      # Contenido: proyectos
    ├── assets/img/            # Avatar y capturas
    └── scripts/
        └── validate_data.py   # Valida los JSON (exit 0 = ok)
```

## Cómo correrlo

### [Portafolio David Peralta](https://david-peralta-rd.github.io/Portfolio_DavidPeralta/) - Github Pages.
