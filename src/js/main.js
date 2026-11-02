// scaffold: hola mundo; T13 lo reemplaza
const url = new URL('../data/profile.json', import.meta.url);
const app = document.getElementById('app');
try {
  const res = await fetch(url);
  if (!res.ok) throw new Error('HTTP ' + res.status);
  const profile = await res.json();
  const h1 = document.createElement('h1');
  h1.textContent = profile.name;
  app.replaceChildren(h1);
} catch (err) {
  console.error(err);
  app.textContent = 'No se pudieron cargar los datos.';
}
