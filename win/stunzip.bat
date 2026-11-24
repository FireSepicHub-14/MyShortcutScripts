@echo off
chcp 65001 > nul
setlocal

if "%~1"=="" (
    echo [Error] 解凍する .tar.zst ファイルを指定してください。
    echo 使用例: stunzip archive.tar.zst
    exit /b 1
)

echo Extracting: "%~1"
zstd -d -T0 -v -M2048MB "%~1" -c | tar -xf -

endlocal
