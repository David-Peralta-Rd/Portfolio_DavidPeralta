from pathlib import Path

from portfolio.content import load_content
from portfolio.render import render_site

CONTENT = Path(__file__).parents[1] / "portfolio" / "content.toml"


def test_render_site_creates_expected_files(tmp_path: Path) -> None:
    render_site(CONTENT, tmp_path)
    assert (tmp_path / "index.html").is_file()
    assert (tmp_path / ".nojekyll").is_file()
    assert (tmp_path / "static").is_dir()
    html = (tmp_path / "index.html").read_text(encoding="utf-8")
    assert load_content(CONTENT)["profile"]["name"] in html