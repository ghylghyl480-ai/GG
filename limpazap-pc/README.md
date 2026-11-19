# LIMPA ZAP PC - limpador que FUNCIONA no Redmi 9A

O site `limzap` so funciona no PC (Chrome do Android nao da acesso
as pastas do celular - limite do sistema, aditivo nenhum resolve).
Este aqui roda NO SEU PC e limpa o celular pelo cabo USB, sem root.

## Uso (preparo de 5 minutos, uma vez)

1. Pega o adb (pasta platform-tools) do guia do Hibernador:
   https://dl.google.com/android/repository/platform-tools-latest-windows.zip
   Descompacta na Area de Trabalho.
2. Copie o `limpar.bat` pra DENTRO da pasta `platform-tools`
   (mesma pasta do adb.exe).
3. Ligue o Redmi 9A no PC com cabo. No celular, toque na
   notificacao USB e escolha "Transferir arquivos".
4. Ajustes > Sobre o telemovel > toque 7x em "Versao MIUI"
   > volte > Opcoes de desenvolvedor > ative "Depuracao USB".
5. Abra o `limpar.bat` (duplo clique) e digite a opcao.
6. No celular aparece "Permitir depuracao USB?": marque
   "Sempre permitir" e OK.

## O que faz (pacientemente seguro)

- **1** Copias ENVIADAS: o WhatsApp guarda DUAS copias de tudo que
  voce manda (a pasta "Sent"). Apagar la nao difere nas conversas
  e a outra pessoa continua com o arquivo.
  Tambem apaga figurinhas e gifs baixados.
- **2** STATUS antigos: ja sumiram pra todo mundo, so ocupavam.
- **3** Os 20 maiores arquivos do celular. Video antigo de 300 MB
  se regenera, app pesado vaum em "Ajustes > Aplicativos".
- **4** Miniaturas da galeria: recriam sozinhas, menores.
- **5** Espaco livre e usados.

## NUNCA toca

Conversas (o banco do WhatsApp fica em criptografia),
contatos, notas de voz RECEBEDAS, fotos da camera, documentos.
