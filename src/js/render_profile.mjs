export function renderProfile(profile, root) {
  const win = document.createElement("div");
  win.className = "window";

  const bar = document.createElement("div");
  bar.className = "window__bar";

  const body = document.createElement("div");
  body.className = "window__body";

  const name = document.createElement("h1");
  name.textContent = profile.name;
  body.appendChild(name);

  const role = document.createElement("p");
  role.textContent = profile.role;
  body.appendChild(role);

  const tagline = document.createElement("p");
  tagline.textContent = profile.tagline;
  body.appendChild(tagline);

  const about = document.createElement("p");
  about.textContent = profile.about;
  body.appendChild(about);

  if (Array.isArray(profile.links)) {
    const nav = document.createElement("nav");
    profile.links.forEach((link) => {
      const a = document.createElement("a");
      a.textContent = link.label;
      a.href = link.url;
      a.target = "_blank";
      a.rel = "noopener noreferrer";
      nav.appendChild(a);
    });
    body.appendChild(nav);
  }

  win.appendChild(bar);
  win.appendChild(body);
  root.appendChild(win);
}