# Portfolio_DavidPeralta

Portafolio para programadores.

## Estructura de carpetas.
```text
Portfolio_DavidPeralta/
├─ index.html                 # EXCEPCIÓN de raíz: lo exige Pages; carga ./src/...
├─ AGENTS.md  CLAUDE.md  SPEC.md  tasks.md  README.md
├─ .gitignore  .gitattributes  scaffold.sh
├─ docs/
│  ├─ DATA_MODEL.md
│  └─ adr/
└─ src/
   ├─ css/
   │  ├─ styles.css           # tokens (:root), ventana mac (.window), base
   │  └─ sections.css         # layout de secciones y media queries
   ├─ js/
   │  ├─ main.js              # carga datos, arma la página, maneja errores
   │  ├─ data.js              # loadJson(fileName)
   │  └─ render/
   │     ├─ hero.js           # renderHero(profile)
   │     ├─ projects.js       # renderProjects(projects, title)
   │     ├─ skills.js         # renderSkills(skillGroups, title)
   │     └─ contact.js        # renderContact(links, title)
   ├─ data/
   │  ├─ profile.json         # perfil, secciones, enlaces, habilidades
   │  └─ projects.json        # lista de proyectos
   ├─ assets/img/             # fotos y capturas (.gitkeep al inicio)
   └─ scripts/
      └─ validate_data.py     # valida los JSON (solo stdlib)
```

## Cómo correrlo

### [Portafolio David Peralta](https://david-peralta-rd.github.io/Portfolio_DavidPeralta/) - Github Pages.
