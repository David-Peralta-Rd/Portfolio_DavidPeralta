# AGENTS.md — Portfolio_DavidPeralta

## Proyecto
Un portafolio de programador que se actualice editando datos (JSON), sin riesgo de romper el código.fr

# AGENTS.md

## Stack
- HTML + CSS + JS vanilla (ES modules, extensión `.mjs`), sin bundler ni dependencias.
- Contenido en `src/data/*.json`; esquema en `docs/DATA_MODEL.md`.
- Validador en Python estándar: `src/scripts/validate_data.py`.
- Hosting: GitHub Pages (`main` / raíz). Sin backend, BD ni Docker.

## Comandos
- Servir local (solo [YO], bloquea la terminal): `python3 -m http.server 8000`
- Validar datos: `uv run --no-project src/scripts/validate_data.py`
- Sintaxis JS: `for f in src/js/*.mjs; do node --check "$f"; done`
- Test, tipos y migraciones: no aplican.
- Nueva sección: contenedor en `index.html` + `src/js/render_<x>.mjs` + llamada en `main.mjs`.

## Estructura
- Raíz: `index.html` (página real), docs de IA, `README.md`, `scaffold.sh`, `docs/`.
- `src/css/` (base, layout, components), `src/js/` (main, data, render_*), `src/data/`, `src/assets/img/`, `src/scripts/`.
- Rutas de `fetch`, `href` y `src` siempre relativas (`src/...`).

## Estilo (Python)
(se mantiene la sección de la plantilla)

## Nunca
- Crear a mano lo que un generador produce (aquí casi no hay generadores).
- Crear código, scripts o `.env` fuera de `src/`; la única excepción es `index.html` de la raíz.
- Usar `innerHTML` con datos de los JSON: solo `textContent` y `setAttribute`.
- Poner contenido (textos, proyectos) dentro de los `.mjs`.
- Enlaces externos sin `rel="noopener noreferrer"`.
- Rutas absolutas que empiecen con `/` (rompen bajo el subpath de Pages).
- Instalar dependencias, usar CDNs o pinear versiones a mano.
- Hacer commit ni push.
- Editar `tasks.md`.
- Tocar archivos que no estén en la columna "Archivos que toca" de la tarea.
- Leer o imprimir `.venv` ni `node_modules`.
- Ejecutar `docker`, `uv add` o un servidor en primer plano.
- Dejar un proceso corriendo.

## Cómo trabajas (modo delegado)

Trabajas sin supervisión inmediata: nadie contesta preguntas mientras corres. Decide con lo
que dicen SPEC.md, tasks.md y este archivo, y si algo no está claro, para y repórtalo.

1. Lee SOLO la fila de tu tarea en `tasks.md` (`grep -n '^| T04 ' tasks.md`) y los documentos
   o secciones que esa fila cita. No leas `SPEC.md` entero ni explores el árbol (`ls -R`,
   `find`): usa las rutas de la tarea.
2. Haz ÚNICAMENTE la tarea que te pidan por ID y solo si está marcada [DELEGAR]. Nunca una
   [YO]. No adelantes tareas siguientes.
3. Toca SOLO los archivos de la columna "Archivos que toca". Si necesitas otro, para y dilo.
4. Escribe un plan de máximo 3 líneas y continúa sin esperar respuesta.
5. Implementa. Después corre el comando de "Verificación (agente)" de la tarea y
   `uv run --no-project src/scripts/validate_data.py` y `for f in src/js/*.mjs; do node --check "$f"; done`.
   No releas archivos que ya leíste. Si un comando puede imprimir mucho, usa sus opciones
   de salida corta (`-q`, `-x`, `--output-format concise`).
6. Si algo falla: corrige y reintenta, máximo 3 veces. Si sigue fallando, PARA y reporta el
   comando exacto y su salida. No cambies tests para que pasen ni toques nada más.
7. No hagas commit ni push. No instales dependencias salvo que la tarea lo pida. No edites
   tasks.md: marcar la tarea como hecha lo hago yo al revisar el diff.
8. Al terminar responde en 10 líneas como máximo: tarea (ID), archivos cambiados, resultado
   de cada comando (ok / falla) y dudas o decisiones que tomaste. No pegues código ni el
   diff: lo reviso con git.

## Cómo trabajas
1. Lee `SPEC.md` y `tasks.md`.
2. Trabaja UNA tarea marcada [DELEGAR]; propón un plan corto antes de escribir código.
3. Corre tests, linter y tipos.
4. Muestra el diff y explica qué cambió y por qué. No hagas commit sin revisión.
