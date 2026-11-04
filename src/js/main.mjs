import { loadJson } from "./data.mjs";
import { renderProfile } from "./render_profile.mjs";
import { renderSkills } from "./render_skills.mjs";
import { renderProjects } from "./render_projects.mjs";

const app = document.getElementById("app");
const profileRoot = document.getElementById("profile");
const skillsRoot = document.getElementById("skills");
const projectsRoot = document.getElementById("projects");

try {
  const [profile, projectsFile] = await Promise.all([
    loadJson("src/data/profile.json"),
    loadJson("src/data/projects.json"),
  ]);
  renderProfile(profile, profileRoot);
  renderSkills(profile.skills, skillsRoot);
  renderProjects(projectsFile.projects, projectsRoot);
} catch (err) {
  const msg = document.createElement("p");
  msg.textContent = "No se pudo cargar el portafolio.";
  app.appendChild(msg);
  console.error(err);
}