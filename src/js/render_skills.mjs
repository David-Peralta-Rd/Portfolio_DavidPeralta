export function renderSkills(skills, root) {
  (skills || []).forEach((group) => {
    const win = document.createElement("div");
    win.className = "window";

    const bar = document.createElement("div");
    bar.className = "window__bar";

    const body = document.createElement("div");
    body.className = "window__body";

    const title = document.createElement("h3");
    title.textContent = group.group;
    body.appendChild(title);

    (group.items || []).forEach((item) => {
      const tag = document.createElement("span");
      tag.className = "tag";
      tag.textContent = item;
      body.appendChild(tag);
    });

    win.appendChild(bar);
    win.appendChild(body);
    root.appendChild(win);
  });
}