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


def test_render_featured_and_external_link(tmp_path: Path) -> None:
    src = CONTENT.read_text(encoding="utf-8")
    src = src.replace("featured = false", "featured = true", 1)
    src = src.replace('language = "Bash"', 'language = "Python"', 1)
    content_path = tmp_path / "content.toml"
    content_path.write_text(src, encoding="utf-8")
    out = tmp_path / "out"
    render_site(content_path, out)
    html = (out / "index.html").read_text(encoding="utf-8")
    assert 'class="card sq featured' in html
    assert "lang-python" in html
    assert "badge-top" in html
    assert 'target="_blank" rel="noopener"' in html