const express = require('express');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;

// Serve static files
app.use(express.static('public'));

// Download endpoint
app.get('/download', (req, res) => {
  const file = path.join(__dirname, 'public', 'shopforce.apk');
  res.download(file, 'ShopForce.apk', (err) => {
    if (err) {
      console.error('Download error:', err);
      res.status(404).send('APK not found');
    } else {
      console.log(`Download from ${req.ip}`);
    }
  });
});

// Health check
app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    version: '1.0.0',
    app: 'ShopForce APK Server'
  });
});

// API endpoint for download link
app.get('/api/download-url', (req, res) => {
  const baseUrl = req.protocol + '://' + req.get('host');
  res.json({
    downloadUrl: `${baseUrl}/download`,
    version: '1.0.0',
    size: '54 MB',
    platform: 'Android'
  });
});

app.listen(PORT, () => {
  console.log(`ShopForce APK Server running on port ${PORT}`);
});
