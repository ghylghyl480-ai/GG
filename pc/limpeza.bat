@echo off
title Limpeza do PC - Kit PC
color 0A

:: ============================================================
::  LIMPEZA - Kit PC (feito pro Positivo T4500 / 4GB)
::  COMO USAR: botao direito -> Executar como administrador
::  O QUE FAZ: apaga arquivos temporarios e lixo de update.
::  NAO apaga seus arquivos, fotos, documentos ou programas.
:: ============================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0E
    echo.
    echo  AVISO: voce abriu sem ser Administrador.
    echo  Feche e abra de novo com: botao direito ^> Executar como administrador
    echo.
    pause
    exit /b
)

echo.
echo  [1/3] Limpando arquivos temporarios do seu usuario...
del /q /f /s "%TEMP%\*" >nul 2>&1

echo  [2/3] Limpando temporarios do Windows e cache de update...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1

echo  [3/3] Limpando cache de DNS...
ipconfig /flushdns >nul 2>&1

color 0A
echo.
echo  ============================================
echo   PRONTO! Limpeza feita.
echo   Dica: reinicie o PC pra ficar redondo.
echo  ============================================
echo.
pause
