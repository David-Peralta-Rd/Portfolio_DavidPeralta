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

/* ===== Carrusel de proyectos (T21) ===== */
(function () {
  "use strict";
  function init() {
    document.querySelectorAll(".projects").forEach(function (container) {
      var isFeatured = container.classList.contains("featured");
      var limit = isFeatured ? 3 : 6;
      var cards = Array.prototype.slice.call(container.children);
      if (cards.length <= limit) return;

      var pages = [];
      for (var i = 0; i < cards.length; i += limit) {
        pages.push(cards.slice(i, i + limit));
      }

      function showPage(index) {
        cards.forEach(function (c) { c.style.display = "none"; });
        pages[index].forEach(function (c) { c.style.display = ""; });
        dots.querySelectorAll("button").forEach(function (b, i) {
          b.setAttribute("aria-current", i === index ? "true" : "false");
          b.style.width = i === index ? "8px" : "6px";
          b.style.height = i === index ? "8px" : "6px";
          b.style.background = i === index ? "var(--accent, #2F6DA8)" : "#888";
        });
        live.textContent = "Página " + (index + 1) + " de " + pages.length;
      }

      var dots = document.createElement("div");
      dots.className = "carousel-dots";
      dots.style.cssText = "display:flex;gap:8px;justify-content:center;margin-top:16px;";
      var live = document.createElement("span");
      live.className = "sr-only";
      live.setAttribute("aria-live", "polite");
      live.style.cssText = "position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0,0,0,0);";
      dots.appendChild(live);

      pages.forEach(function (_, i) {
        var btn = document.createElement("button");
        btn.type = "button";
        btn.setAttribute("aria-label", "Ir a la página " + (i + 1));
        btn.style.cssText = "width:6px;height:6px;border-radius:50%;border:0;background:#888;cursor:pointer;padding:0;";
        btn.addEventListener("click", function (e) {
          e.preventDefault();
          e.stopPropagation();
          current = i;
          showPage(current);
          restart();
        });
        dots.appendChild(btn);
      });

      container.parentNode.insertBefore(dots, container.nextSibling);

      var current = 0;
      showPage(current);

      var timer = null;
      function restart() {
        if (timer) clearInterval(timer);
        timer = setInterval(function () {
          current = (current + 1) % pages.length;
          showPage(current);
        }, 5000);
      }
      restart();

      function pause() { if (timer) { clearInterval(timer); timer = null; } }
      container.addEventListener("mouseenter", pause);
      container.addEventListener("mouseleave", restart);
      container.addEventListener("focusin", pause);
      container.addEventListener("focusout", restart);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
