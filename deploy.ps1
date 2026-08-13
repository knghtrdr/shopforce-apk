# Deploy ShopForce APK to Heroku (PowerShell)

Write-Host ""
Write-Host "========================================"
Write-Host "ShopForce APK Deployment to Heroku"
Write-Host "========================================"
Write-Host ""

Set-Location C:\Users\nbandari\SFMCShopDemo\apk-host

# Step 1: Check Heroku CLI
Write-Host "[1/6] Checking Heroku CLI..." -ForegroundColor Yellow
$herokuInstalled = Get-Command heroku -ErrorAction SilentlyContinue

if (-not $herokuInstalled) {
    Write-Host "  Heroku CLI not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Heroku CLI..." -ForegroundColor Yellow
    Write-Host "Please download from: https://devcenter.heroku.com/articles/heroku-cli" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Or run:" -ForegroundColor Yellow
    Write-Host "  winget install Heroku.HerokuCLI" -ForegroundColor White
    Write-Host ""
    Write-Host "After installation, close and reopen PowerShell, then run this script again." -ForegroundColor Yellow
    Read-Host "Press Enter to open download page"
    Start-Process "https://devcenter.heroku.com/articles/heroku-cli"
    exit
} else {
    Write-Host "  ✓ Heroku CLI found" -ForegroundColor Green
}

# Step 2: Check Git
Write-Host ""
Write-Host "[2/6] Checking Git..." -ForegroundColor Yellow
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue

if (-not $gitInstalled) {
    Write-Host "  Git not found! Install Git first." -ForegroundColor Red
    Start-Process "https://git-scm.com/download/win"
    exit
} else {
    Write-Host "  ✓ Git found" -ForegroundColor Green
}

# Step 3: Initialize Git
Write-Host ""
Write-Host "[3/6] Initializing Git repository..." -ForegroundColor Yellow
if (-not (Test-Path .git)) {
    git init
    Write-Host "  ✓ Git initialized" -ForegroundColor Green
} else {
    Write-Host "  ✓ Git already initialized" -ForegroundColor Green
}

# Step 4: Heroku Login
Write-Host ""
Write-Host "[4/6] Logging in to Heroku..." -ForegroundColor Yellow
Write-Host "  (Browser will open for authentication)" -ForegroundColor Gray
heroku login

if ($LASTEXITCODE -ne 0) {
    Write-Host "  ✗ Heroku login failed" -ForegroundColor Red
    exit
}
Write-Host "  ✓ Logged in to Heroku" -ForegroundColor Green

# Step 5: Create Heroku App
Write-Host ""
Write-Host "[5/6] Creating Heroku app..." -ForegroundColor Yellow
$appName = "shopforce-apk-" + (Get-Random -Maximum 9999)
heroku create $appName

if ($LASTEXITCODE -ne 0) {
    Write-Host "  App name might be taken, trying another..." -ForegroundColor Yellow
    $appName = "shopforce-" + (Get-Random -Maximum 99999)
    heroku create $appName
}

Write-Host "  ✓ App created: $appName" -ForegroundColor Green

# Step 6: Commit and Deploy
Write-Host ""
Write-Host "[6/6] Deploying to Heroku..." -ForegroundColor Yellow

git add .
git commit -m "Initial commit - ShopForce APK hosting"
git push heroku master

if ($LASTEXITCODE -ne 0) {
    # Try main branch
    Write-Host "  Trying main branch..." -ForegroundColor Yellow
    git branch -M main
    git push heroku main
}

Write-Host ""
Write-Host "========================================"
Write-Host "DEPLOYMENT COMPLETE!"
Write-Host "========================================"
Write-Host ""

# Get app info
$appUrl = heroku apps:info --json | ConvertFrom-Json | Select-Object -ExpandProperty web_url

Write-Host "Your APK is now hosted at:" -ForegroundColor Green
Write-Host "  $appUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "Download link:" -ForegroundColor Green
Write-Host "  ${appUrl}download" -ForegroundColor Cyan
Write-Host ""
Write-Host "Share this link with your users!" -ForegroundColor Yellow
Write-Host ""

$openBrowser = Read-Host "Open app in browser? (Y/N)"
if ($openBrowser -eq 'Y' -or $openBrowser -eq 'y') {
    heroku open
}

Write-Host ""
Write-Host "To view logs: heroku logs --tail" -ForegroundColor Gray
Write-Host "To update APK: Copy new APK, git add, commit, push" -ForegroundColor Gray
Write-Host ""
