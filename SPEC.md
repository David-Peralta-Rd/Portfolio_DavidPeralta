# Portfolio_DavidPeralta — SPEC

## Problema
Un programador Python necesita una página personal que muestre quién es, qué construye y cómo contactarlo. Debe verse moderna y cuidada, sin exageraciones, y publicarse gratis y sin servidor.

## Usuarios
- Reclutadores y clientes que revisan el portafolio en 1–2 minutos, en móvil o escritorio.
- David, que edita el contenido en un solo archivo y ve el cambio al instante en local.

## Dentro de alcance (MVP)
- Una página con: hero (texto + tarjeta de código Python), proyectos, stack, sobre mí y contacto.
- Estilo: squircle (`corner-shape: squircle` con fallback a bordes redondeados), minimalista, paleta azul Python con acento amarillo, tipografía Geist.
- Tema claro/oscuro con botón y preferencia guardada.
- Contenido en `content.toml`; HTML generado con Jinja2 a `src/site/dist/`.
- Local: `uv run serve` con recarga en vivo. Producción: GitHub Pages vía GitHub Actions.

## Fuera de alcance
Backend, base de datos, blog, CMS, formulario de contacto con servidor, analítica, i18n, animaciones complejas, Docker, dominio propio.

## Criterios de aceptación (medibles)
1. `uv run build` termina con código 0 y genera `dist/index.html` y `dist/.nojekyll`.
2. `dist/index.html` no contiene `href="/` ni `src="/` (funciona bajo subruta de Pages).
3. Editar `content.toml`, una plantilla o `style.css` con `uv run serve` activo recarga el navegador sin acción manual.
4. `pytest`, `ruff check` y `mypy` terminan con código 0.
5. El sitio se ve bien a 375 px y a 1280 px, en claro y oscuro.
6. La URL pública de Pages responde 200 y contiene el nombre del autor.
