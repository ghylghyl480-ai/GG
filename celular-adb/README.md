# 🔋 Hibernador GG — apps de verdade sem root (via ADB)

O jeito que os apps Play Store fazem por baixo dos panos (e cobram por isso).
NÃO desinstala nada — só congela (o app some até você reativar) e impede rodar no fundo.

## O que você precisa (uma vez só)

1. **Baixar adb no PC:** https://dl.google.com/android/repository/platform-tools-latest-windows.zip
2. Extrair o zip. Vai aparecer uma pasta `platform-tools` com o `adb.exe`
3. Copie `hibernar.bat` e `reativar.bat` para DENTRO da pasta `platform-tools`
4. No celular: **Configurações → Sobre o telefone → toque 7x em "Versão MIUI"** (ativa modo desenvolvedor)
5. **Configurações → Configurações adicionais → Opções do desenvolvedor**:
   - Ative **Depuração USB**
6. Ligue o celular no Positivo pelo cabo USB
7. No celular vai aparecer **"Permitir depuração USB?"** → toque **PERMITIR**
8. Dê 2 cliques no `hibernar.bat`

## O que o Hibernador congela

- Facebook/Instagram + serviços que ficam ligados 24h
- Netflix, Spotify, Xbox/serviços da Xiaomi (analytics, loja de apps MIUI, cloud, player e vídeo da Xiaomi que ninguém usa) — no Redmi 9A da pra respirar
- WhatsApp/Redes: continua funcionando normal, só para de puxar bateria no fundo

## Voltou tudo (desceu as bolas)

Dê 2 cliques no `reativar.bat` — tudo volta em 1 minuto.

## Dicas MIUI que valem mais que app pago

- Config → Bateria → **Economia de bateria** → "ocasional" nos apps pesados
- Config → Apps → Gerenciar apps → WhatsApp → **Início automático: DESLIGADO** (só isso já mata 80% do incômodo)
- Config → Apps → **Permissions → Autostart**: desligue de TUDO que não for essencial
- Segurança app → Acelerar → manter sem apps no fundo

## ⚠️ Honestidade

- Isso aqui **não precisa de root** e é reversível
- Congelar app de **banco, securitária ou sistema** (com.miui.securitycenter) NÃO — por isso não tá na lista
- Depois de atualização do sistema, alguns apps podem voltar — rode de novo
