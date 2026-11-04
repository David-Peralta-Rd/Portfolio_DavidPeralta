(function () {
  var root = document.documentElement;
  var btn = document.getElementById('theme');
  var moon = document.getElementById('ico-moon');
  var sun = document.getElementById('ico-sun');

  function effective() {
    var t = root.getAttribute('data-theme');
    if (t) return t;
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }
  function paint() {
    var dark = effective() === 'dark';
    sun.hidden = !dark;
    moon.hidden = dark;
  }
  try {
    var saved = localStorage.getItem('dp-theme');
    if (saved === 'light' || saved === 'dark') root.setAttribute('data-theme', saved);
  } catch (e) { }
  paint();
  btn.addEventListener('click', function () {
    var next = effective() === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    try { localStorage.setItem('dp-theme', next); } catch (e) { }
    paint();
  });
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', paint);

  var copy = document.getElementById('copy');
  var mail = document.getElementById('mail');
  copy.addEventListener('click', function () {
    var text = mail.textContent;
    function done() {
      copy.textContent = 'Copiado';
      setTimeout(function () { copy.textContent = 'Copiar'; }, 1600);
    }
    function fallback() {
      var r = document.createRange();
      r.selectNodeContents(mail);
      var s = window.getSelection();
      s.removeAllRanges();
      s.addRange(r);
    }
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).then(done, fallback);
    } else {
      fallback();
    }
  });
})();
