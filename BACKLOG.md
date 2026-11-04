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

## Prioridad alta (nuevo)

### Carrusel / límite de proyectos en pantalla
- Mostrar como máximo 6 proyectos destacados (top) y 10 normales a la vez.
- Carrusel ligero en `static/main.js` (sin dependencias): rotación automática cada N segundos, pausa al hover/foco, puntos (dots) como control manual, `aria-live` para accesibilidad.
- Mantener la regla de no `href="/"` ni `src="/"` (T11).

### Estilo visual más destacado para proyectos top
- Tarjeta más grande (2 columnas), borde/acento diferenciado y badge "Top".
- Ajustar `static/style.css` sin cambiar valores existentes (solo añadir reglas nuevas).

### Animación de borde por lenguaje (solo proyectos top)
- Añadir campo `language` a `[[projects]]` (Python, JavaScript, Rust, Go, etc.) en `docs/DATA_MODEL.md` y `content.toml`.
- Al hacer hover sobre una tarjeta top, animar el borde con los colores del lenguaje y mostrar el icono del lenguaje centrado en la parte superior de la tarjeta.
- Preparar paleta/icono para varios lenguajes aunque no se usen todos desde el inicio.
- Implementar con CSS (variables por lenguaje) + un poco de JS para aplicar la clase según `language`.


## Nota de alcance
- Los cambios de modelo de datos (`DATA_MODEL.md`) y `content.toml` los decide el mantenedor (etiqueta [YO]).
- El agente solo toca archivos listados en la columna "Archivos que toca" de cada tarea.
