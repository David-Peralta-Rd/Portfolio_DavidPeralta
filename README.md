# Portfolio_DavidPeralta

# Estructura de carpetas
```markdown
Portfolio_DavidPeralta/
├── AGENTS.md                        # reglas para el agente
├── CLAUDE.md                        # plantilla
├── SPEC.md                          # alcance
├── tasks.md                         # tareas
├── README.md                        # plantilla
├── scaffold.sh                      # crea todo lo de abajo
├── .gitignore                       # ignora dist, .venv, caches
├── .gitattributes                   # LF en *.sh
├── .github/workflows/pages.yml      # despliegue a Pages (T13; GitHub lo exige en la raíz)
├── docs/
│   ├── DATA_MODEL.md                # esquema de content.toml
│   ├── adr/                         # decisiones
│   └── reference/David_Peralta.html # diseño de referencia (solo lectura)
└── src/site/
    ├── pyproject.toml               # generado por uv init
    ├── uv.lock                      # generado por uv
    ├── .python-version              # generado por uv python pin
    ├── dist/                        # salida del build (no se versiona)
    ├── tests/
    │   ├── test_content.py          # carga y validación
    │   ├── test_render.py           # el build produce los archivos
    │   └── test_paths.py            # sin rutas absolutas en el HTML
    └── portfolio/
        ├── __init__.py              # paquete
        ├── cli.py                   # comandos build y serve (≤ 25 líneas)
        ├── content.py               # load_content (carga y valida)
        ├── content.toml             # TODOS los textos del sitio
        ├── render.py                # render_site: plantilla + estáticos a dist/
        ├── templates/
        │   ├── base.html.j2         # head, header, footer, script
        │   └── index.html.j2        # secciones de la página
        └── static/
            ├── style.css            # estilos (squircle, temas)
            └── main.js              # tema y botón copiar
```

# Live Portfolio
### [David Peralta Portfolio](https://david-peralta-rd.github.io/Portfolio_DavidPeralta/) - Github Pages
