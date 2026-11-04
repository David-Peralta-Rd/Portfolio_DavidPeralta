# BACKLOG — Portfolio_DavidPeralta

Ideas y mejoras futuras. Las tareas concretas se añaden a `tasks.md` por el mantenedor (no las edita el agente).

## Prioridad alta

### Proyectos destacados (top) vs. normales
- Añadir campo `featured = true|false` a `[[projects]]` en `docs/DATA_MODEL.md` y `content.toml`.
- En `index.html.j2`, renderizar los `featured` en una sección "Proyectos destacados" con tarjeta grande (2 columnas) y el resto en la grilla actual.
- Ordenar: destacados primero, luego el resto.
- Tests: `load_content` sigue validando claves; nuevo test de render con un proyecto `featured`.

### Enlaces a proyectos más visibles
- Añadir `url` (ya reservado en el modelo) como enlace en cada tarjeta (`<a href="{{ p.url }}">`), con `rel="noopener"` y `target="_blank"` cuando exista.
- Botón "Ver proyecto" en la tarjeta; ocultar si `url` es null/vacío.
- Test de rutas: los enlaces externos deben ser `https://` y no romper la regla de no `href="/"`.

## Prioridad media

### SEO y metadatos
- Meta description, Open Graph y Twitter Card en `base.html.j2` (usando `profile`).
- `sitemap.xml` y `robots.txt` generados en `render.py`.

### Accesibilidad
- `aria-label` en enlaces de proyecto y botones de copia.
- Navegación por teclado y foco visible.

### Contenido
- Sección de experiencia/línea de tiempo.
- Descarga de CV (PDF) en `static/`.

## Prioridad baja

- Internacionalización (es/en) con selector de idioma.
- Modo de alto contraste.
- Analítica privacy-first (Plausible/Umami).

## Nota de alcance
- Los cambios de modelo de datos (`DATA_MODEL.md`) y `content.toml` los decide el mantenedor (etiqueta [YO]).
- El agente solo toca archivos listados en la columna "Archivos que toca" de cada tarea.