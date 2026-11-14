# Meus apps

- **[🎵 Meu Player](player/)** — player de música estilo Spotify para os seus próprios arquivos (funciona no celular, instalável via GitHub Pages).
- **[🤖 Mano IA](chat-pwa/)** — chat com a IA da Mistral, instalável no celular (você usa a sua própria chave da API, salva só no seu aparelho).
- **[🥗 FitBot IA](fitbot/)** — chat de dieta com IA: manda receitas com o que você tem em casa e conta as calorias do dia (mesma chave do Mano IA, salva só no aparelho).
- **[⚔️ Arena IA](arena/)** — várias IAs (DeepSeek, Mistral, Llama...) conversando juntas num grupo, todas com memória compartilhada. Usa chave gratuita do OpenRouter.
- **[💻 Chat Mistral servidor](public/)** — chat com a API da Mistral (precisa rodar localmente com Node.js).

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

## 🤖 Mano IA (pasta `chat-pwa/`)

PWA de chat com `mistral-small-latest` que roda inteiramente no navegador: a chave da API é colada pelo usuário e salva apenas no `localStorage` do aparelho (nunca vai para nenhum servidor). Respostas em streaming, histórico salvo, instalável na tela inicial. Acesse `/chat-pwa/` no Pages.

## 🎵 Player de música (pasta `player/`)

App estático (PWA) que toca os seus próprios MP3s, estilo Spotify, instalável na tela inicial do celular. Veja o [README do player](player/README.md). Para publicar: *Settings → Pages → Deploy from a branch → main / (root) → Save* e acesse `https://ghylghyl480-ai.github.io/GG/player/`.
