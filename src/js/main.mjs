// hola mundo: muestra el nombre leído del JSON
import { loadJson } from "./data.mjs";

const el = document.getElementById("name");
try {
  const profile = await loadJson("src/data/profile.json");
  el.textContent = profile.name;
} catch (err) {
  el.textContent = "No se pudo cargar el perfil";
  console.error(err);
}
