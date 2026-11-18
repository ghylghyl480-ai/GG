@echo off
title Reativar apps - desfaz o Hibernador GG
echo Voltando apps ao normal...
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
  com.whatsapp
  com.facebook.lite
  com.twitter.android
  com.zhiliaoapp.musically
  com.reddit.frontpage
) do (
  adb shell pm enable %%a 2>nul
  adb shell cmd appops set %%a RUN_IN_BACKGROUND allow 2>nul
  adb shell dumpsys deviceidle whitelist +%%a 2>nul
)
echo PRONTO - tudo de volta ao normal.
pause
