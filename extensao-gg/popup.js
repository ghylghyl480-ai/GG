const BASE = "https://ghylghyl480-ai.github.io/GG/";
const APPS = [
  { em: "💰", nome: "GG Studio (vitrine)", path: "vitrine/" },
  { em: "🥗", nome: "FitBot", path: "fitbot/" },
  { em: "💪", nome: "Meu Time IA", path: "time/" },
  { em: "🤖", nome: "Mano IA", path: "chat-pwa/" },
  { em: "⚔️", nome: "Arena IA", path: "arena/" },
  { em: "🎵", nome: "Toca Aí", path: "toca/" },
  { em: "🎧", nome: "Player do GG", path: "player/" },
  { em: "🔗", nome: "Guarda Aí", path: "guarda/" },
  { em: "🎬", nome: "Estúdio de Cortes", path: "estudio/" },
  { em: "☀️", nome: "Meu Clima", path: "clima/" },
];

const grid = document.getElementById("grid");

const hub = document.createElement("button");
hub.className = "hub";
hub.innerHTML = "🏠 Abrir o hub GG (todos os apps)";
hub.onclick = () => chrome.tabs.create({ url: BASE });
grid.appendChild(hub);

for (const app of APPS) {
  const b = document.createElement("button");
  const em = document.createElement("span");
  em.className = "em";
  em.textContent = app.em;
  b.appendChild(em);
  b.appendChild(document.createTextNode(app.nome));
  b.onclick = () => chrome.tabs.create({ url: BASE + app.path });
  grid.appendChild(b);
}
