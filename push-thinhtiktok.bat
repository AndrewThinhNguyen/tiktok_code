@echo off
setlocal

echo ≡⚙️ Bắt đầu push vào 2 repository...

REM === COPY FILES VÀO FOLDER tuwi (chỉ giữ .py + .bat)
mkdir tuwi 2>nul
xcopy /Y *.py tuwi\
xcopy /Y *.bat tuwi\

REM === REPO 1: jamesdis/content (push toàn bộ gốc)
echo.
echo ≡📤 Push lên GitHub: content
git add *.py *.bat
git commit -m "📌 Push code chính"
git push origin main

REM === REPO 2: AndrewThinhNguyen/tiktok_code (chỉ push folder tuwi/)
cd tuwi
git init
git remote add origin https://github.com/AndrewThinhNguyen/tiktok_code.git
git checkout -b main 2>nul
git add .
git commit -m "📦 Push folder tuwi/"
git push -u origin main -f
cd ..

echo.
echo ✅ Đã push cả 2 nơi xong!
pause
