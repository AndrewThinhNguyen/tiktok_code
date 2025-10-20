@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set TUWI_DIR=tuwi
set REMOTE1=https://github.com/jamesdis/content.git
set REMOTE2=https://github.com/AndrewThinhNguyen/tiktok_code.git

echo 🧹 Dọn thư mục "%TUWI_DIR%" cũ...
rmdir /s /q "%TUWI_DIR%" 2>nul
mkdir "%TUWI_DIR%"

echo 📁 Copy các file *.py và *.bat vào thư mục "%TUWI_DIR%"...
for %%f in (*.py) do copy /Y "%%f" "%TUWI_DIR%" >nul
for %%f in (*.bat) do (
    if not "%%f"=="quick_push.bat" copy /Y "%%f" "%TUWI_DIR%" >nul
)

echo.
echo 🟢 BƯỚC 1: PUSH TO jamesdis/content
git add *.py *.bat
git commit -m "🚀 Push .py + .bat files (root)" 2>nul
git remote set-url origin %REMOTE1%
git push -u origin main

echo.
echo 🟣 BƯỚC 2: PUSH FOLDER 'tuwi' TO AndrewThinhNguyen/tiktok_code
cd "%TUWI_DIR%"
git init
git remote add origin %REMOTE2%
git fetch origin main
git checkout -b main origin/main

git add .
git commit -m "📦 Push tuwi folder content"
git push origin main

cd ..
echo.
echo ✅ Đã push xong lên cả 2 GitHub repo!
pause
