@echo off
setlocal

set PORT=8765
set URL=http://localhost:%PORT%/ux-prototype.html

echo.
echo [Intent Fabric] ========================================
echo [Intent Fabric]  Starting dev server on port %PORT%
echo [Intent Fabric] ========================================
echo.

REM 查找占用端口的进程并杀掉
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%PORT% " ^| findstr "LISTENING"') do (
  echo [Intent Fabric] Found existing process on port %PORT% ^(PID=%%a^) -- killing...
  taskkill /F /PID %%a >nul 2>&1
  if errorlevel 1 (
    echo [Intent Fabric] WARNING: failed to kill PID=%%a
  ) else (
    echo [Intent Fabric] Killed PID=%%a
  )
)

echo.
echo [Intent Fabric] Serving %~dp0 at %URL%
echo [Intent Fabric] Press Ctrl-C in this window to stop
echo.

REM 启动默认浏览器
start "" "%URL%"

REM 在当前目录启动 HTTP 服务(前台阻塞,Ctrl-C 结束)
cd /d "%~dp0"
python -m http.server %PORT%
