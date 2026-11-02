# Portfolio_DavidPeralta: SPEC

## Problema
Un programador necesita una carta de presentación pública, bonita y fácil de mantener, donde el contenido se edite sin riesgo de romper el código.

## Usuarios
- Reclutadores y empresas que revisan perfil y proyectos en pocos minutos.
- Colegas y clientes que llegan por un enlace.
- Yo (David), que edito perfil y proyectos solo en JSON.

## Dentro de alcance (v1)
- Una página con 4 secciones: Sobre mí, Proyectos, Habilidades, Contacto.
- Estilo minimalista con "ventanas" tipo macOS: barra de título con 3 puntos y bordes redondeados.
- Diseño responsivo (móvil primero).
- Contenido en `src/data/profile.json` y `src/data/projects.json`; el JS solo lo renderiza.
- Script de validación de los JSON.
- Publicado en GitHub Pages.

## Fuera de alcance
Backend, base de datos, formulario de contacto, blog, CMS, modo oscuro, multilenguaje, animaciones complejas, analítica, frameworks JS, npm y build.

## Criterios de aceptación
1. Editar un proyecto en `projects.json` y recargar la página lo refleja sin tocar ningún `.js`.
2. `python3 src/scripts/validate_data.py` sale con 0 con los datos reales y con 1 si falta un campo obligatorio.
3. Ninguna línea de `src/js/` contiene texto personal, ni enlaces, ni uso de `innerHTML`.
4. Sin scroll horizontal a 360 px; se ve bien a 768 px y a 1280 px.
5. Lighthouse (móvil): Accessibility ≥ 90 y Best Practices ≥ 90.
6. La URL de GitHub Pages carga con las rutas relativas correctas, sin errores 404 en consola.
