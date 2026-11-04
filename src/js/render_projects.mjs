export function renderProjects(projects, root) {
  const sorted = [...(projects || [])].sort((a, b) => a.order - b.order);

  sorted.forEach((project) => {
    const article = document.createElement("article");
    article.className = "window";

    const bar = document.createElement("div");
    bar.className = "window__bar";

    const body = document.createElement("div");
    body.className = "window__body";

    const name = document.createElement("h3");
    name.textContent = project.name;
    body.appendChild(name);

    const summary = document.createElement("p");
    summary.textContent = project.summary;
    body.appendChild(summary);

    (project.tags || []).forEach((tag) => {
      const span = document.createElement("span");
      span.className = "tag";
      span.textContent = tag;
      body.appendChild(span);
    });

    const codeLink = document.createElement("a");
    codeLink.textContent = "Código";
    codeLink.href = project.repo_url;
    codeLink.target = "_blank";
    codeLink.rel = "noopener noreferrer";
    body.appendChild(codeLink);

    if (project.demo_url) {
      const demoLink = document.createElement("a");
      demoLink.textContent = "Demo";
      demoLink.href = project.demo_url;
      demoLink.target = "_blank";
      demoLink.rel = "noopener noreferrer";
      body.appendChild(demoLink);
    }

    article.appendChild(bar);
    article.appendChild(body);
    root.appendChild(article);
  });
}