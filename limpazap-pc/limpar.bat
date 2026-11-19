@echo off
title LIMPA ZAP PC - limpador de celular via USB
setlocal enabledelayedexpansion

:inicio
cls
echo ============================================
echo    LIMPA ZAP PC  (celular via cabo USB)
echo ============================================
echo.
echo  1  WhatsApp: apagar COPIAS ENVIADAS (Sent) - o que voce mandou
echo  2  WhatsApp: apagar STATUS antigos
echo  3  Os 20 maiores arquivos do celular (lista e apaga escolhendo)
echo  4  Miniaturas da galeria (thumbnails - recriam sozinhas)
echo  5  Espaco livre do celular
echo.
echo  0  Sair
echo.
set /p op="Digite o numero e Enter: "

if "%op%"=="1" goto sent
if "%op%"=="2" goto status
if "%op%"=="3" goto top
if "%op%"=="4" goto thumbs
if "%op%"=="5" goto espaco
if "%op%"=="0" exit /b
goto inicio

:checa
adb get-state >nul 2>&1
if errorlevel 1 (
  echo.
  echo  [ERRO] Celular nao encontrado.
  echo  - Pluga o cabo USB e escolhe "Transferir arquivos" na notificacao
  echo  - Depuracao USB ativa (Inicio automatico do guia)
  echo  - Se pedir "Permitir depuracao USB?", marque SEMPRE e OK
  pause
  goto inicio
)
exit /b

:sent
call :checa
echo.
echo  Isso apaga SOMENTE pastas Sent (copias do que voce ENVIOU).
echo  Nada do que voce recebeu, nem conversas, e tocado.
set /p confo="  Continuar? (s/n): "
if not "%confo%"=="s" goto inicio
echo  Limpando imagens enviadas...
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images/Sent' -type f -delete" 2>nul
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Video/Sent' -type f -delete" 2>nul
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Voice Notes/Sent' -type f -delete" 2>nul
adb shell "find '/sdcard/WhatsApp/Media/WhatsApp Images/Sent' -type f -delete" 2>nul
adb shell "find '/sdcard/WhatsApp/Media/WhatsApp Video/Sent' -type f -delete" 2>nul
adb shell "find '/sdcard/WhatsApp/Media/WhatsApp Voice Notes/Sent' -type f -delete" 2>nul
echo  Limpando figurinhas baixadas antigas...
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Stickers' -type f -delete" 2>nul
echo  Limpando gifs do papel de parede/irrelevante...
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Animated Gifs' -type f -delete" 2>nul
echo.
echo  [OK] Copias enviadas apagadas. O que voce RECEBEU continua intacto.
pause
goto inicio

:status
call :checa
echo.
echo  Apagar arquivos de STATUS antigos (ja sumiram pra ninguem)?
set /p confo="  Continuar? (s/n): "
if not "%confo%"=="s" goto inicio
adb shell "find '/sdcard/Android/media/com.whatsapp/WhatsApp/Media/.Statuses' -type f -delete" 2>nul
adb shell "find '/sdcard/WhatsApp/Media/.Statuses' -type f -delete" 2>nul
echo  [OK] Status antigos apagados.
pause
goto inicio

:top
call :checa
echo.
echo  Procurando... 30 segundos.
adb shell "find /sdcard -type f -size +20480k 2>/dev/null | xargs -r du -k 2>/dev/null | sort -rn | head -20"
echo.
echo  (esquerda = KB. 100000 KB = 100 MB)
set /p caminho="  Cola o caminho do arquivo pra apagar (vazio = voltar): "
if "%caminho%"=="" goto inicio
adb shell "rm '%caminho%'"
echo  [OK] Apagado.
pause
goto inicio

:thumbs
call :checa
adb shell "find '/sdcard/DCIM/.thumbnails' -type f -delete" 2>nul
adb shell "rm -rf '/sdcard/Movies/.thumbnails' '/sdcard/Pictures/.thumbnails'" 2>nul
echo  [OK] Miniaturas apagadas - a galeria recria menores.
echo  [DICA] Depois abra a Galeria uma vez pra recrar certo.
pause
goto inicio

:espaco
call :checa
echo.
adb shell df -h /sdcard | findstr /v "tmpfs overlay"
echo.
pause
goto inicio
