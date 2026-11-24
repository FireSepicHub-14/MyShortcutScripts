@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo [Error] 圧縮対象のフォルダまたはファイルを指定してください。
    echo 使用例: stzip target_folder
    exit /b 1
)

set "target=%~1"

:: 末尾の \ や / を削除（PowerShellの TrimEnd 相当の処理）
:trim_loop
if "!target:~-1!"=="\" set "target=!target:~0,-1!" & goto trim_loop
if "!target:~-1!"=="/" set "target=!target:~0,-1!" & goto trim_loop

echo Compressing: "!target!" -^> "!target!.tar.zst"
tar -cf - "!target!" | zstd --ultra -20 -T0 -v --zstd=wlog=27 --long=28 -M1024MB -o "!target!.tar.zst"

endlocal
