# SPEC.md — Portfolio_DavidPeralta

## Problema
Un portafolio de programador que se actualice editando datos (JSON), sin riesgo de romper el código.

## Usuarios
- Reclutadores y clientes: ven perfil, habilidades y proyectos en móvil o escritorio.
- David: edita `src/data/*.json` y hace push.

## Dentro de alcance (v1)
- Página única con secciones Perfil, Habilidades, Proyectos y Contacto.
- Estilo minimalista con ventanas tipo macOS; responsive (móvil, tablet, escritorio).
- Contenido leído de `src/data/profile.json` y `src/data/projects.json`.
- Validador de JSON con código de salida.
- Metadatos básicos (description, Open Graph).
- Publicación en GitHub Pages.

## Fuera de alcance
Backend, BD, CMS, blog, formulario de contacto, i18n, animaciones complejas, botón de tema, analítica, framework JS, bundler, dominio propio.

## Criterios de aceptación
1. `uv run --no-project src/scripts/validate_data.py` termina en 0.
2. Cambiar un texto o añadir un proyecto en el JSON se refleja al recargar, sin editar `.mjs`.
3. A 360, 768 y 1280 px no hay scroll horizontal y nada se superpone.
4. Lighthouse móvil: Performance ≥ 90 y Accessibility ≥ 90.
5. Si un JSON falla al cargar, la página muestra un mensaje visible, no una pantalla vacía.
6. Todo enlace externo lleva `rel="noopener noreferrer"`.
