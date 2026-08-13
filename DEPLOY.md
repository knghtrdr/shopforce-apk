# 🚀 Deploy ShopForce APK to Heroku

**Everything is ready! Just follow these steps.**

---

## ✅ FILES READY

```
apk-host/
├── package.json       ✅ Node.js config
├── server.js          ✅ Express server
├── Procfile           ✅ Heroku config
└── public/
    ├── index.html     ✅ Download page
    └── shopforce.apk  ✅ Your APK (54 MB)
```

---

## 📋 DEPLOYMENT STEPS

### **1. Install Heroku CLI (if not installed)**

```powershell
# Windows
winget install Heroku.HerokuCLI

# Or download from:
# https://devcenter.heroku.com/articles/heroku-cli
```

### **2. Login to Heroku**

```bash
heroku login
```

This opens browser for authentication.

### **3. Deploy**

```bash
cd C:\Users\nbandari\SFMCShopDemo\apk-host

# Install dependencies
npm install

# Initialize git
git init
git add .
git commit -m "Initial commit - ShopForce APK hosting"

# Create Heroku app
heroku create shopforce-apk

# Deploy
git push heroku master

# Open app
heroku open
```

---

## 🎉 DONE!

**Your APK is now hosted at:**
```
https://shopforce-apk.herokuapp.com/
```

**Direct download link:**
```
https://shopforce-apk.herokuapp.com/download
```

**Health check:**
```
https://shopforce-apk.herokuapp.com/health
```

---

## 📱 SHARE WITH USERS

### **Option 1: Direct Link**
```
https://shopforce-apk.herokuapp.com/download
```

### **Option 2: QR Code**

Generate QR code at: https://www.qr-code-generator.com
Input: `https://shopforce-apk.herokuapp.com/download`

### **Option 3: Branded Page**
```
https://shopforce-apk.herokuapp.com/
```
Users see nice download page with instructions

---

## 🔄 UPDATE APK

When you have a new APK:

```bash
# Copy new APK
cp ../android/app/build/outputs/apk/release/app-release.apk public/shopforce.apk

# Update version in public/index.html

# Commit and deploy
git add public/shopforce.apk public/index.html
git commit -m "Update APK to v1.0.1"
git push heroku master
```

---

## 💰 COST

**Heroku Eco Dyno:**
- $5/month
- Multiple apps
- Always on (no sleep)
- Custom domains
- HTTPS

**Free Alternatives:**
- Render.com
- Railway.app
- Fly.io
- Vercel (with workarounds for large files)

---

## 📊 MONITOR

```bash
# View logs
heroku logs --tail

# Check app status
heroku ps

# Open app
heroku open
```

---

## 🌐 CUSTOM DOMAIN (Optional)

```bash
# Add domain
heroku domains:add download.yourcompany.com

# Heroku will give you DNS target
# Add CNAME record in your DNS:
#   download.yourcompany.com → <heroku-dns-target>

# Enable SSL (automatic)
heroku certs:auto:enable
```

---

## 🎯 QUICK COPY-PASTE

```bash
cd C:\Users\nbandari\SFMCShopDemo\apk-host
npm install
git init
git add .
git commit -m "ShopForce APK hosting"
heroku login
heroku create shopforce-apk
git push heroku master
heroku open
```

**That's it!** Your APK is now publicly hosted! 🎉
