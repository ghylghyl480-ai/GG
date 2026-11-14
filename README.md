# Meus apps

- **[🎵 Meu Player](player/)** — player de música estilo Spotify para os seus próprios arquivos (funciona no celular, instalável via GitHub Pages).
- **[🤖 Chat Mistral](public/)** — chat com a API da Mistral (precisa rodar localmente com Node.js).

---

# Chat Mistral (app web mínimo)

Chat simples que chama a API da Mistral com o SDK oficial em TypeScript/JavaScript (`@mistralai/mistralai`), usando o modelo `mistral-small-latest`. A chave `MISTRAL_API_KEY` fica apenas no servidor (nunca vai para o navegador) e as respostas chegam em streaming via SSE.

## Estrutura

- `server.js` — servidor Express: serve a interface e expõe `POST /api/chat` (proxy para a Mistral).
- `public/index.html` — interface de chat (sem build, HTML/CSS/JS puro).

## Como rodar localmente

```bash
# 1. Instalar dependências
npm install

# 2. Definir sua chave da API (pegue em https://console.mistral.ai)
export MISTRAL_API_KEY=sua-chave-aqui

# 3. Executar
npm start

# Abra http://localhost:3000
```

Para desenvolvimento com auto-reload ao salvar:

```bash
npm run dev
```

Opcional: copie `.env.example` para `.env` e use `node --env-file=.env server.js` para carregar a chave de um arquivo (não versione o `.env`).

---

## 🎵 Player de música (pasta `player/`)

App estático (PWA) que toca os seus próprios MP3s, estilo Spotify, instalável na tela inicial do celular. Veja o [README do player](player/README.md). Para publicar: *Settings → Pages → Deploy from a branch → main / (root) → Save* e acesse `https://ghylghyl480-ai.github.io/GG/player/`.
