@echo off
setlocal enabledelayedexpansion

:: === CẤU HÌNH ===
set BASE_DIR=%cd%
set TUWI_FOLDER=%BASE_DIR%\tuwi
set REPO_MAIN=https://github.com/jamesdis/content.git
set REPO_TUWICODE=https://github.com/AndrewThinhNguyen/tiktok_code.git

:: === TẠO FOLDER tuwi nếu chưa có ===
if not exist "%TUWI_FOLDER%" (
    echo 🔧 Tạo thư mục tuwi...
    mkdir "%TUWI_FOLDER%"
)

:: === 1. PUSH CODE CHÍNH LÊN REPO jamesdis/content ===
echo 💻 PUSH lên repo chính: %REPO_MAIN%
cd /d "%BASE_DIR%"
git add *.py *.bat
git commit -m "🔁 quick update"
git pull origin main --rebase
git push -u origin main

:: === 2. COPY FILE VÀO THƯ MỤC tuwi ===
echo 🧩 Copy các file .py và .bat vào tuwi...
xcopy /Y /Q "%BASE_DIR%\*.py" "%TUWI_FOLDER%\"
xcopy /Y /Q "%BASE_DIR%\*.bat" "%TUWI_FOLDER%\"

:: === 3. PUSH THƯ MỤC tuwi LÊN REPO tiktok_code ===
cd /d "%TUWI_FOLDER%"
if not exist ".git" (
    git init
    git remote add origin %REPO_TUWICODE%
    git branch -M main
) else (
    git remote set-url origin %REPO_TUWICODE%
)

:: Gỡ bỏ ignore nếu có
cd /d "%BASE_DIR%"
findstr /V /C:"tuwi/" .gitignore > temp_gitignore.txt
move /Y temp_gitignore.txt .gitignore > nul

cd /d "%TUWI_FOLDER%"
git add . -f
git commit -m "📦 Push folder tuwi/"
git pull origin main --rebase
git push -u origin main

echo 🟢 Đã PUSH xong cả hai repo!
pause
