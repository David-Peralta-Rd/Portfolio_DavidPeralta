"""Carga y valida el contenido del sitio desde un TOML."""

import tomllib
from pathlib import Path
from typing import Any

REQUIRED_KEYS: frozenset[str] = frozenset(
    {"profile", "links", "projects", "stack", "about", "facts"}
)


def load_content(path: Path) -> dict[str, Any]:
    with path.open("rb") as f:
        data = tomllib.load(f)
    missing = REQUIRED_KEYS - set(data)
    if missing:
        raise ValueError(
            f"Faltan claves obligatorias en el contenido: {sorted(missing)}"
        )
    return data
