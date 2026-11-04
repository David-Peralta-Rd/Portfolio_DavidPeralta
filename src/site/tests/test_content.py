from pathlib import Path

import pytest

from portfolio.content import load_content

CONTENT = Path(__file__).parents[1] / "portfolio" / "content.toml"
REQUIRED_KEYS = {"profile", "links", "projects", "stack", "about", "facts"}


def test_load_real_content_has_six_keys() -> None:
    data = load_content(CONTENT)
    assert REQUIRED_KEYS.issubset(data.keys())
    assert len(data) == len(REQUIRED_KEYS)


def test_missing_profile_raises(tmp_path: Path) -> None:
    path = tmp_path / "content.toml"
    path.write_text(
        "[links]\n"
        "[[links]]\nlabel = \"x\"\nurl = \"https://example.com\"\n",
        encoding="utf-8",
    )
    with pytest.raises(ValueError):
        load_content(path)


def test_missing_file_raises(tmp_path: Path) -> None:
    with pytest.raises(FileNotFoundError):
        load_content(tmp_path / "does-not-exist.toml")
