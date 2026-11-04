"""Validador de src/data/*.json. Solo biblioteca estándar."""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PROFILE_PATH = ROOT / "src" / "data" / "profile.json"
PROJECTS_PATH = ROOT / "src" / "data" / "projects.json"


def is_str(v):
    return isinstance(v, str)


def is_int(v):
    return isinstance(v, int) and not isinstance(v, bool)


def is_list(v):
    return isinstance(v, list)


def is_dict(v):
    return isinstance(v, dict)


def load_json(path, errors):
    try:
        with path.open(encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        errors.append(f"ERROR: {path.name}: archivo no encontrado")
    except json.JSONDecodeError as e:
        errors.append(f"ERROR: {path.name}: JSON inválido: {e.msg}")
    except OSError as e:
        errors.append(f"ERROR: {path.name}: no se pudo leer: {e}")
    return None


def validate_profile(data, errors):
    fname = PROFILE_PATH.name
    if not is_dict(data):
        errors.append(f"ERROR: {fname}: la raíz debe ser un objeto")
        return

    # campos requeridos
    required = {"name", "role", "tagline", "about", "avatar", "links", "skills"}
    for field in required:
        if field not in data:
            errors.append(f"ERROR: {fname}: falta campo requerido '{field}'")
    # campos extra no se prohíben

    # name
    v = data.get("name")
    if v is not None:
        if not is_str(v):
            errors.append(f"ERROR: {fname}: 'name' debe ser string")
        elif not (1 <= len(v) <= 60):
            errors.append(f"ERROR: {fname}: 'name' debe tener 1-60 caracteres")

    # role
    v = data.get("role")
    if v is not None:
        if not is_str(v):
            errors.append(f"ERROR: {fname}: 'role' debe ser string")
        elif len(v) > 60:
            errors.append(f"ERROR: {fname}: 'role' debe tener <= 60 caracteres")

    # tagline
    v = data.get("tagline")
    if v is not None:
        if not is_str(v):
            errors.append(f"ERROR: {fname}: 'tagline' debe ser string")
        elif len(v) > 140:
            errors.append(f"ERROR: {fname}: 'tagline' debe tener <= 140 caracteres")

    # about
    v = data.get("about")
    if v is not None:
        if not is_str(v):
            errors.append(f"ERROR: {fname}: 'about' debe ser string")
        elif len(v) > 600:
            errors.append(f"ERROR: {fname}: 'about' debe tener <= 600 caracteres")

    # avatar
    v = data.get("avatar")
    if v is not None and v is not None:
        if not (v is None or is_str(v)):
            errors.append(f"ERROR: {fname}: 'avatar' debe ser string o null")

    # links
    links = data.get("links")
    if links is not None:
        if not is_list(links):
            errors.append(f"ERROR: {fname}: 'links' debe ser array")
        elif len(links) < 1:
            errors.append(f"ERROR: {fname}: 'links' debe tener >= 1 elemento")
        else:
            for i, link in enumerate(links):
                if not is_dict(link):
                    errors.append(f"ERROR: {fname}: 'links[{i}]' debe ser objeto")
                    continue
                # label
                label = link.get("label")
                if "label" not in link:
                    errors.append(f"ERROR: {fname}: 'links[{i}].label' requerido")
                elif not is_str(label):
                    errors.append(f"ERROR: {fname}: 'links[{i}].label' debe ser string")
                elif len(label) > 30:
                    errors.append(f"ERROR: {fname}: 'links[{i}].label' debe tener <= 30 caracteres")
                # url
                url = link.get("url")
                if "url" not in link:
                    errors.append(f"ERROR: {fname}: 'links[{i}].url' requerido")
                elif not is_str(url):
                    errors.append(f"ERROR: {fname}: 'links[{i}].url' debe ser string")
                elif not (url.startswith("https://") or url.startswith("mailto:")):
                    errors.append(f"ERROR: {fname}: 'links[{i}].url' debe empezar con https:// o mailto:")

    # skills
    skills = data.get("skills")
    if skills is not None:
        if not is_list(skills):
            errors.append(f"ERROR: {fname}: 'skills' debe ser array")
        elif len(skills) < 1:
            errors.append(f"ERROR: {fname}: 'skills' debe tener >= 1 elemento")
        else:
            for i, sg in enumerate(skills):
                if not is_dict(sg):
                    errors.append(f"ERROR: {fname}: 'skills[{i}]' debe ser objeto")
                    continue
                # group
                group = sg.get("group")
                if "group" not in sg:
                    errors.append(f"ERROR: {fname}: 'skills[{i}].group' requerido")
                elif not is_str(group):
                    errors.append(f"ERROR: {fname}: 'skills[{i}].group' debe ser string")
                elif len(group) > 30:
                    errors.append(f"ERROR: {fname}: 'skills[{i}].group' debe tener <= 30 caracteres")
                # items
                items = sg.get("items")
                if "items" not in sg:
                    errors.append(f"ERROR: {fname}: 'skills[{i}].items' requerido")
                elif not is_list(items):
                    errors.append(f"ERROR: {fname}: 'skills[{i}].items' debe ser array")
                elif len(items) < 1:
                    errors.append(f"ERROR: {fname}: 'skills[{i}].items' debe tener >= 1 elemento")
                else:
                    for j, it in enumerate(items):
                        if not is_str(it):
                            errors.append(f"ERROR: {fname}: 'skills[{i}].items[{j}]' debe ser string")
                        elif len(it) > 30:
                            errors.append(f"ERROR: {fname}: 'skills[{i}].items[{j}]' debe tener <= 30 caracteres")


def validate_projects(data, errors):
    fname = PROJECTS_PATH.name
    if not is_dict(data):
        errors.append(f"ERROR: {fname}: la raíz debe ser un objeto")
        return
    if "projects" not in data:
        errors.append(f"ERROR: {fname}: falta campo requerido 'projects'")
        return
    projects = data.get("projects")
    if not is_list(projects):
        errors.append(f"ERROR: {fname}: 'projects' debe ser array")
        return

    seen_ids = set()
    for i, p in enumerate(projects):
        if not is_dict(p):
            errors.append(f"ERROR: {fname}: 'projects[{i}]' debe ser objeto")
            continue
        required = {"id", "name", "summary", "tags", "repo_url", "demo_url", "order"}
        for field in required:
            if field not in p:
                errors.append(f"ERROR: {fname}: 'projects[{i}]' falta campo requerido '{field}'")

        # id
        pid = p.get("id")
        if "id" in p:
            if not is_str(pid):
                errors.append(f"ERROR: {fname}: 'projects[{i}].id' debe ser string")
            else:
                if pid in seen_ids:
                    errors.append(f"ERROR: {fname}: 'projects[{i}].id' duplicado: {pid}")
                seen_ids.add(pid)

        # name
        name = p.get("name")
        if "name" in p:
            if not is_str(name):
                errors.append(f"ERROR: {fname}: 'projects[{i}].name' debe ser string")
            elif len(name) > 60:
                errors.append(f"ERROR: {fname}: 'projects[{i}].name' debe tener <= 60 caracteres")

        # summary
        summary = p.get("summary")
        if "summary" in p:
            if not is_str(summary):
                errors.append(f"ERROR: {fname}: 'projects[{i}].summary' debe ser string")
            elif len(summary) > 200:
                errors.append(f"ERROR: {fname}: 'projects[{i}].summary' debe tener <= 200 caracteres")

        # tags
        tags = p.get("tags")
        if "tags" in p:
            if not is_list(tags):
                errors.append(f"ERROR: {fname}: 'projects[{i}].tags' debe ser array")
            elif len(tags) < 1:
                errors.append(f"ERROR: {fname}: 'projects[{i}].tags' debe tener >= 1 elemento")
            else:
                for j, t in enumerate(tags):
                    if not is_str(t):
                        errors.append(f"ERROR: {fname}: 'projects[{i}].tags[{j}]' debe ser string")
                    elif len(t) > 20:
                        errors.append(f"ERROR: {fname}: 'projects[{i}].tags[{j}]' debe tener <= 20 caracteres")

        # repo_url
        repo_url = p.get("repo_url")
        if "repo_url" in p:
            if not is_str(repo_url):
                errors.append(f"ERROR: {fname}: 'projects[{i}].repo_url' debe ser string")
            elif not repo_url.startswith("https://"):
                errors.append(f"ERROR: {fname}: 'projects[{i}].repo_url' debe empezar con https://")

        # demo_url
        demo_url = p.get("demo_url")
        if "demo_url" in p:
            if demo_url is not None:
                if not is_str(demo_url):
                    errors.append(f"ERROR: {fname}: 'projects[{i}].demo_url' debe ser string o null")
                elif not demo_url.startswith("https://"):
                    errors.append(f"ERROR: {fname}: 'projects[{i}].demo_url' debe empezar con https://")

        # order
        order = p.get("order")
        if "order" in p:
            if not is_int(order):
                errors.append(f"ERROR: {fname}: 'projects[{i}].order' debe ser entero")
            elif order < 1:
                errors.append(f"ERROR: {fname}: 'projects[{i}].order' debe ser >= 1")


def main() -> int:
    errors = []
    profile_data = load_json(PROFILE_PATH, errors)
    if profile_data is not None:
        validate_profile(profile_data, errors)
    projects_data = load_json(PROJECTS_PATH, errors)
    if projects_data is not None:
        validate_projects(projects_data, errors)

    if errors:
        for e in errors:
            print(e)
        return 1
    print("OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
