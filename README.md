# Portfolio_DavidPeralta

Portafolio para programadores.

## Editar contenido

Los textos y proyectos viven en `src/data/profile.json` y `src/data/projects.json`. Edita esos archivos siguiendo el esquema de `docs/DATA_MODEL.md`. Valida con:

```
uv run --no-project src/scripts/validate_data.py
```

## Correr local

```
python3 -m http.server 8000
```

Abre `http://localhost:8000`.

## Publicar

GitHub Pages desde la rama `main` y la raíz del repositorio. Las rutas son relativas (`src/...`) para funcionar bajo `/Portfolio_DavidPeralta/`.