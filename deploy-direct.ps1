# Deploy using direct Heroku path

Write-Host ""
Write-Host "========================================"
Write-Host "ShopForce APK Deployment"
Write-Host "========================================"
Write-Host ""

Set-Location C:\Users\nbandari\SFMCShopDemo\apk-host

# Use direct path to Heroku
$herokuPath = "C:\Program Files\heroku\bin\heroku.cmd"

# Check if it exists
if (-not (Test-Path $herokuPath)) {
    Write-Host "Heroku not found at expected location." -ForegroundColor Red
    Write-Host "Please restart PowerShell or add Heroku to PATH." -ForegroundColor Yellow
    exit
}

# Step 1: Initialize Git
Write-Host "[1/5] Initializing Git..." -ForegroundColor Yellow
if (-not (Test-Path .git)) {
    git init
    git branch -M main
    Write-Host "  ✓ Git initialized" -ForegroundColor Green
} else {
    Write-Host "  ✓ Git already initialized" -ForegroundColor Green
}

# Step 2: Heroku Login
Write-Host ""
Write-Host "[2/5] Logging in to Heroku..." -ForegroundColor Yellow
Write-Host "  (Browser will open)" -ForegroundColor Gray
& $herokuPath login

# Step 3: Create app
Write-Host ""
Write-Host "[3/5] Creating Heroku app..." -ForegroundColor Yellow
$appName = "shopforce-apk-" + (Get-Random -Minimum 1000 -Maximum 9999)
& $herokuPath create $appName

# Step 4: Commit files
Write-Host ""
Write-Host "[4/5] Committing files..." -ForegroundColor Yellow
git add .
git commit -m "ShopForce APK hosting"
Write-Host "  ✓ Files committed" -ForegroundColor Green

# Step 5: Deploy
Write-Host ""
Write-Host "[5/5] Deploying to Heroku..." -ForegroundColor Yellow
Write-Host "  (This may take 2-3 minutes)" -ForegroundColor Gray
git push heroku main

Write-Host ""
Write-Host "========================================"
Write-Host "DONE!"
Write-Host "========================================"
Write-Host ""

# Open app
Write-Host "Opening app..." -ForegroundColor Yellow
& $herokuPath open

Write-Host ""
Write-Host "Your APK download link:" -ForegroundColor Cyan
& $herokuPath apps:info --json | ConvertFrom-Json | Select-Object -ExpandProperty web_url | ForEach-Object { Write-Host "  ${_}download" -ForegroundColor Green }
Write-Host ""
