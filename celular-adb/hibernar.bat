@echo off
title Hibernador GG - congelar apps que comem bateria
echo ============================================
echo   HIBERNADOR GG - Apps que bebem bateria
echo   (Redmi 9A / MIUI - nao desinstala nada)
echo ============================================
echo.
echo [1/3] Checando o celular...
adb devices
echo.
echo Se aparecer "unauthorized", destrave a tela do
echo celular e toque em PERMITIR na janela que abriu.
echo.
pause
echo [2/3] Congelando apps pesados (podem voltar com "reativar.bat"):
for %%a in (
  com.facebook.katana
  com.facebook.orca
  com.facebook.appmanager
  com.facebook.system
  com.instagram.android
  com.netflix.mediaclient
  com.spotify.music
  com.microsoft.skydrive
  com.miui.analytics
  com.xiaomi.mipicks
  com.miui.cloudservice
  com.milink.service
  com.miui.player
  com.miui.video
  com.miui.gamebooster
  com.miuihybrid.execution
  com.mi.misdk.gromanager
  com.google.android.apps.tachyon
  com.google.android.videos
  com.google.android.music
  com.android.browser
) do (
  echo --- comando pm disable-user %%a
  adb shell pm disable-user --user 0 %%a 2>nul
)
echo.
echo [3/3] Restringindo apps uteis a NAO rodarem no fundo
echo        (voltam normal quando voce abrir):
for %%a in (
  com.whatsapp
  com.facebook.lite
  com.twitter.android
  com.zhiliaoapp.musically
  com.reddit.frontpage
) do (
  echo --- comando am kill / deviceidle whitelist off
  adb shell dumpsys deviceidle whitelist -%%a 2>nul
  adb shell cmd appops set %%a RUN_IN_BACKGROUND ignore 2>nul
)
echo.
echo ============================================
echo   PRONTO! Apps congelados e sob controle.
echo   Ficou estranho? Rode reativar.bat
echo ============================================
pause
