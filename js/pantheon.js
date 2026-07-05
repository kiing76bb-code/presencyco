/**
 * Pantheon Treatment — lightweight cinematic behaviors (no dependencies)
 */
(function () {
  'use strict';

  /* Scroll reveal */
  var reveals = document.querySelectorAll('.pantheon-reveal');
  if (reveals.length && 'IntersectionObserver' in window) {
    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: '0px 0px -40px 0px' }
    );
    reveals.forEach(function (el) {
      observer.observe(el);
    });
  } else {
    reveals.forEach(function (el) {
      el.classList.add('is-visible');
    });
  }

  /* Constellation mesh — connect hero anchor points */
  var svg = document.getElementById('pantheonConstellation');
  if (!svg) return;

  var nodes = [
    { x: 0.12, y: 0.22 },
    { x: 0.28, y: 0.38 },
    { x: 0.45, y: 0.18 },
    { x: 0.62, y: 0.32 },
    { x: 0.78, y: 0.24 },
    { x: 0.88, y: 0.42 },
    { x: 0.35, y: 0.58 },
    { x: 0.55, y: 0.72 },
    { x: 0.72, y: 0.65 },
    { x: 0.18, y: 0.78 },
  ];

  var edges = [
    [0, 1], [1, 2], [2, 3], [3, 4], [4, 5],
    [1, 6], [3, 6], [3, 7], [7, 8], [6, 9], [9, 0],
  ];

  function draw() {
    var w = window.innerWidth;
    var h = window.innerHeight;
    svg.setAttribute('viewBox', '0 0 ' + w + ' ' + h);
    svg.innerHTML = '';

    var pts = nodes.map(function (n) {
      return { x: n.x * w, y: n.y * h };
    });

    edges.forEach(function (pair) {
      var a = pts[pair[0]];
      var b = pts[pair[1]];
      var line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      line.setAttribute('x1', a.x);
      line.setAttribute('y1', a.y);
      line.setAttribute('x2', b.x);
      line.setAttribute('y2', b.y);
      svg.appendChild(line);
    });

    pts.forEach(function (p, i) {
      var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
      circle.setAttribute('cx', p.x);
      circle.setAttribute('cy', p.y);
      circle.setAttribute('r', i % 3 === 0 ? 2.5 : 1.5);
      svg.appendChild(circle);
    });
  }

  var reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  draw();
  if (!reduced) {
    window.addEventListener('resize', draw);
    setInterval(function () {
      nodes.forEach(function (n) {
        n.x += (Math.random() - 0.5) * 0.004;
        n.y += (Math.random() - 0.5) * 0.004;
        n.x = Math.max(0.05, Math.min(0.95, n.x));
        n.y = Math.max(0.08, Math.min(0.92, n.y));
      });
      draw();
    }, 3200);
  }
})();
