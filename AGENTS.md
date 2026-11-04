# AGENTS.md — Portfolio_DavidPeralta

## Proyecto
Portafolio para programador David Peralta Backend IA

## Stack
- Python 3.15 + uv. Sitio estático: Jinja2 genera `src/site/dist/`; se publica en GitHub Pages.
- Sin backend, BD ni Docker. Calidad: pytest, ruff, mypy.

## Comandos
- Build: `cd src/site && uv run build`
- Desarrollo con recarga: `cd src/site && uv run serve` (http://localhost:8000)
- Test: `cd src/site && uv run pytest -q -x`
- Lint: `cd src/site && uv run ruff check --output-format concise .`
- Tipos: `cd src/site && uv run mypy portfolio`
- Comandos nuevos: `[project.scripts]` en `src/site/pyproject.toml` + `cli.py`

## Estructura
- Código: `src/site/portfolio/` (cli.py, content.py, render.py, templates/, static/, content.toml)
- Tests: `src/site/tests/`. Esquema de datos: `docs/DATA_MODEL.md`. Referencia visual: `docs/reference/`.

## Nunca
- Crear a mano lo que un generador produce (`uv init`, `uv add`, `uv lock`).
- Crear código o scripts fuera de `src/`. Sin Docker.
- Poner lógica de negocio en cli.py. Usar rutas absolutas (`/...`) en el HTML.
- Pinear versiones de paquetes a mano ni usar pre-releases.
- Hacer commit ni push. Editar tasks.md. Tocar archivos fuera de la columna "Archivos que toca".
- Leer ni imprimir `uv.lock`, `.venv` ni `dist`.
- Ejecutar `uv add` salvo que la tarea lo pida. Dejar un proceso en primer plano.

## Estilo (Python)
(conserva aquí la sección de la plantilla)

## Cómo trabajas (modo delegado)

Trabajas sin supervisión inmediata: nadie contesta preguntas mientras corres. Decide con lo que dicen SPEC.md, tasks.md y este archivo, y si algo no está claro, para y repórtalo.

1. Lee SOLO la fila de tu tarea en `tasks.md` (`grep -n '^| T04 ' tasks.md`) y los documentos o secciones que esa fila cita. No leas `SPEC.md` entero ni explores el árbol (`ls -R`, `find`): usa las rutas de la tarea.
2. Haz ÚNICAMENTE la tarea que te pidan por ID y solo si está marcada [DELEGAR]. Nunca una [YO]. No adelantes tareas siguientes.
3. Toca SOLO los archivos de la columna "Archivos que toca". Si necesitas otro, para y dilo.
4. Escribe un plan de máximo 3 líneas y continúa sin esperar respuesta.
5. Implementa. Después corre el comando de "Verificación (agente)" de la tarea y `cd src/site && uv run pytest -q -x`, `cd src/site && uv run ruff check --output-format concise .`, `cd src/site && uv run mypy portfolio`. No releas archivos que ya leíste. Si un comando puede imprimir mucho, usa sus opciones de salida corta (`-q`, `-x`, `--output-format concise`).
6. Si algo falla: corrige y reintenta, máximo 3 veces. Si sigue fallando, PARA y reporta el comando exacto y su salida. No cambies tests para que pasen ni toques nada más.
7. No hagas commit ni push. No instales dependencias salvo que la tarea lo pida. No edites tasks.md: marcar la tarea como hecha lo hago yo al revisar el diff.
8. Al terminar responde en 10 líneas como máximo: tarea (ID), archivos cambiados, resultado de cada comando (ok / falla) y dudas o decisiones que tomaste. No pegues código ni el diff: lo reviso con git.

## Cómo trabajas
1. Lee `SPEC.md` y `tasks.md`.
2. Trabaja UNA tarea marcada [DELEGAR]; propón un plan corto antes de escribir código.
3. Corre tests, linter y tipos.
4. Muestra el diff y explica qué cambió y por qué. No hagas commit sin revisión.
