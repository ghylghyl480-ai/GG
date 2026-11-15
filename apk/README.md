# 📦 Guarda Aí — APK Android v1.0.0

APK instalável do app **Guarda Aí** (seu cofre de links de vídeos).

- **Pacote:** `br.com.ghylghyl480.guardaai`
- **Versão:** 1.0.0
- **Tamanho:** ~980 KB
- **Compatível com:** Android 5.0+ — funciona no **Xiaomi Redmi 9A (32 bits arm32)** e em qualquer celular moderno.

## 📲 Como instalar no celular

1. Baixe o arquivo [`Guarda-Ai.apk`](Guarda-Ai.apk) aqui desta pasta (botão de download no GitHub, ou baixe direto no celular pelo navegador).
2. No Android, toque no arquivo baixado.
3. O celular vai pedir permissão para **instalar apps de fontes desconhecidas** — autorize (é só para o navegador/gerenciador de arquivos instalar o seu APK).
4. Toque em **Instalar**. Pronto, o Guarda Aí aparece na sua tela inicial como app normal. 🎉

Depois de instalado, você pode compartilhar vídeos do TikTok/Instagram/YouTube direto pelo botão **Compartilhar → Guarda Aí** que o link já é salvo.

## ⚠️ Detalhes técnicos (honesto)

- O app abre com uma **barra de endereço fina** do Chrome no topo (Custom Tabs). Isso é porque o site está num endereço de projeto do GitHub Pages e o Android exige um arquivo de verificação (`assetlinks.json`) na raiz do domínio para o modo tela cheia — não dá para publicar nesse domínio de projeto. O app funciona 100%, só tem essa barrinha.
- O APK é assinado com uma chave gerada automaticamente pelo PWABuilder. **A chave de assinatura não está neste repositório** (por segurança — quem tem a chave pode publicar atualizações em nome do app). Guarde-a em um lugar seguro se você a baixou do PWABuilder.

## 🔄 Como atualizar o APK no futuro

Quando você mudar o app no site, gere um APK novo:

1. Acesse [pwabuilder.com](https://www.pwabuilder.com)
2. Cole o endereço: `https://ghylghyl480-ai.github.io/GG/guarda/`
3. Clique em **Package for stores → Android → Generate**
4. Baixe o zip e pegue o `.apk` de dentro.

> **Importante:** se você gerar com uma chave de assinatura *diferente*, o Android vai exigir **desinstalar o app antigo antes de instalar o novo** (os links salvos ficam no site, então não perde nada). Se usar a mesma chave, atualiza por cima normal.
