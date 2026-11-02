# AGENTS.md — Portfolio_DavidPeralta

## Proyecto
<una línea: qué es y para quién>

## Stack
- Sitio estático para GitHub Pages: HTML + CSS + JavaScript nativo (módulos ES) + JSON.
- Sin npm, sin build, sin frameworks, sin CDNs, sin dependencias.
- Python 3 solo para `http.server` y `src/scripts/validate_data.py` (stdlib).
- JS: `const`/`let`, funciones pequeñas, `createElement` + `textContent`, nunca `innerHTML`.
- Todo el texto personal vive en `src/data/*.json`, nunca en el JS.

## Comandos (desde la raíz)
- Levantar local: `python3 -m http.server 8000` → http://localhost:8000/ (`file://` no sirve para cargar el JSON).
- Producción: push a `main`; GitHub Pages sirve `index.html` de la raíz.
- Test: `python3 src/scripts/validate_data.py`
- Lint / tipos: no aplica en v1.
- Migraciones, Docker, `[project.scripts]`, reconstruir imágenes: no aplica.
- Crear una sección nueva: crear `src/js/render/<x>.js` y registrarla en `src/js/main.js`.

## Estructura
- Raíz: `index.html` (exigido por Pages), archivos de IA, `README.md`, `docs/`, `scaffold.sh`.
- `src/css/` estilos, `src/js/` lógica y `src/js/render/` una función por sección, `src/data/` JSON, `src/assets/img/` imágenes, `src/scripts/` utilidades.

## Nunca
- Nunca crear a mano lo que un generador produce.
- Nunca crear código, scripts, `.env` ni configuración fuera de `src/` (excepto `index.html` en la raíz).
- Nunca usar `innerHTML`, `eval` ni texto personal dentro de archivos `.js`.
- Nunca añadir dependencias, npm, frameworks ni CDNs.
- Nunca usar rutas absolutas (`/src/...`): siempre relativas, por la subruta de Pages.
- Nunca hacer commit ni push.
- Nunca editar `tasks.md`.
- Nunca tocar archivos que no estén en la columna "Archivos que toca" de la tarea.

## Cómo trabajas (modo delegado)

Trabajas sin supervisión inmediata: nadie contesta preguntas mientras corres. Decide con lo
que dicen SPEC.md, tasks.md y este archivo, y si algo no está claro, para y repórtalo.

1. Lee `SPEC.md` y `tasks.md`. Lee otros documentos solo si la tarea los menciona.
2. Haz ÚNICAMENTE la tarea que te pidan por ID y solo si está marcada [DELEGAR]. Nunca una
   [YO]. No adelantes tareas siguientes.
3. Toca SOLO los archivos de la columna "Archivos que toca". Si necesitas otro, para y dilo.
4. Escribe un plan de máximo 3 líneas y continúa sin esperar respuesta.
5. Implementa. Después corre el comando de "Verificación (agente)" de la tarea y `python3 src/scripts/validate_data.py` (existe desde T03; lint y tipos no aplican en v1).
6. Si algo falla: corrige y reintenta, máximo 3 veces. Si sigue fallando, PARA y reporta el
   comando exacto y su salida. No cambies tests para que pasen ni toques nada más.
7. No hagas commit ni push. No instales dependencias salvo que la tarea lo pida. No edites
   tasks.md: marcar la tarea como hecha lo hago yo al revisar el diff.
8. Al terminar responde solo con: tarea (ID), archivos cambiados, resultado de cada comando
   (ok / falla) y dudas o decisiones que tomaste.

## Cómo trabajas
1. Lee `SPEC.md` y `tasks.md`.
2. Trabaja UNA tarea marcada [DELEGAR]; propón un plan corto antes de escribir código.
3. Corre tests, linter y tipos.
4. Muestra el diff y explica qué cambió y por qué. No hagas commit sin revisión.
