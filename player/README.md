# 🎵 Meu Player

Player de música estilo Spotify que roda no navegador do celular ou PC — e pode ser **instalado como app** na tela inicial. Ele toca **os seus próprios arquivos de música** (MP3, M4A, OGG, WAV, FLAC), sem anúncios, sem assinatura, sem internet depois de carregado.

## Funcões

- Lista de músicas com capa, artista e duração (lê as tags ID3 dos MP3s)
- Play/pause, próxima/anterior, barra de progresso, tempo
- Aleatório (🔀) e repetir (🔁 / 🔂)
- Músicas ficam **salvas no aparelho** (IndexedDB) — adiciona uma vez só
- Controles na tela de bloqueio (Media Session)
- Instalável como app (PWA)

## Como usar no celular (Xiaomi, Android)

1. Publique este projeto no **GitHub Pages** (ver passos no README da raiz ou abaixo).
2. No celular, abra o link do Pages, pasta `player/`.
3. Toque em **＋ Músicas** e escolha os MP3s do aparelho.
4. No menu do Chrome (⋮), toque em **"Adicionar à tela inicial"** — o app fica instalado como o Spotify.

## Como rodar localmente no PC

```bash
cd player
python3 -m http.server 8080
# abra http://localhost:8080
```

(qualquer servidor estático funciona; não precisa de Node nem build)
