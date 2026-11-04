from pathlib import Path

from portfolio.render import render_site

CONTENT = Path(__file__).parents[1] / "portfolio" / "content.toml"


def test_rendered_html_has_no_absolute_paths(tmp_path: Path) -> None:
    render_site(CONTENT, tmp_path)
    html = (tmp_path / "index.html").read_text(encoding="utf-8")
    assert 'href="/' not in html
    assert 'src="/' not in html