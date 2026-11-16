# AGENTS.md — Manual do repositório GG

Instruções para agentes de IA (Vibe Code e outros) trabalhando neste repositório.

## Quem manda aqui

- Dono: **Ghyl** (`ghylghyl480-ai`), iniciante, fala português do Brasil informal.
- **Sempre responder em pt-BR, tom informal e amigável**, explicando como se fosse pra alguém novo.
- Explicar passos simples e numerados; nunca assumir que ele conhece git, terminal ou inglês.

## O que é este repositório

Coleção de apps web **100% estáticos** (HTML/CSS/JS puro, **sem build step**) servidos pelo GitHub Pages em `https://ghylghyl480-ai.github.io/GG/`.

| Pasta | App | Descrição |
|---|---|---|
| `/` (raiz) | Hub | `index.html` com links pra todos os apps |
| `public/` + `server.js` | Chat Node | Chat com API Mistral (SDK oficial, roda só no PC com `MISTRAL_API_KEY`) |
| `player/` | Player de música | PWA offline, MP3 locais, playlists, equalizador |
| `chat-pwa/` | Mano IA | Chat PWA com Mistral |
| `fitbot/` | FitBot IA | Assistente de dieta + contador de calorias |
| `arena/` | Arena IA | Vários bots conversando entre si (OpenRouter) |
| `time/` | Meu Time IA | Time de IAs ajudando o Ghyl (memória, pesquisa web, imagens) |
| `guarda/` | Guarda Aí | Cofre de links com share target do Android |
| `apk/` | APKs | APKs gerados (ex.: `Guarda-Ai.apk`) |

## Regras de ouro (SEGUIR SEMPRE)

1. **Todo app é PWA**: precisa de `manifest.webmanifest` + `sw.js` + ícones 192/512.
2. **Ao mudar qualquer app, bumpar a versão do cache** no `sw.js` dele (ex.: `guarda-v1` → `guarda-v2`) — senão o usuário fica preso na versão antiga.
3. **NUNCA usar `alert()`, `prompt()` nem `confirm()`** — não funcionam direito em PWA instalada no Android. Usar modais customizados (ver `askModal()`/`toast()` em `time/index.html`).
4. **Chaves de API ficam no cliente** (localStorage: `mistral-key`, `openrouter-key`), nunca hardcoded no código.
5. **Sem frameworks, sem npm, sem build** para os apps estáticos — arquivo único `index.html` com CSS/JS inline quando possível.
6. **Streaming SSE** para respostas de IA (parse de `data:` lines, `[DONE]`, `choices[0].delta.content`).
7. Modelos grátis da OpenRouter: **carregar dinamicamente** de `https://openrouter.ai/api/v1/models` (IDs fixos morrem rápido — já causou 404).

## Fluxo de trabalho

- Mudanças entram por branch `vibe/<slug>-8ba1c8` → PR → **o Ghyl dá o merge manualmente**.
- Não fazer push direto na branch padrão.
- APKs são gerados via API do PWABuilder CloudAPK (`generateApkZip`) e salvos em `apk/`.
- **Nunca commitar** `signing.keystore`, chaves, tokens ou `.env`.

## Coisas que o Ghyl quer no futuro

- Editar/cortar vídeos próprios que ele subir na pasta `videos/` (ffmpeg está disponível no sandbox).
- Gerar APKs para os outros apps (player, mano-ia, fitbot, arena, time).
- Automations/agents na workspace Mistral dele.
