# The Ovens Secret 🍞

A beautiful, artisan-inspired Flutter web application for baking enthusiasts. Handcrafted with love by Priya Gupta.

## ✨ Features

- 🍰 **Our Menu** - Comprehensive catalog of custom cakes, brownies, cookies, and chocolates.
- 🥖 **Artisan Recipes** - Step-by-step guides for mastering bread making at home.
- 👩‍🍳 **Priya's Story** - Learn about the heart and hands behind the oven.
- 💬 **WhatsApp Ordering** - Direct contact for custom orders and inquiries.
- 📱 **Fully Responsive** - Seamless experience on mobile, tablet, and desktop.
- 🚀 **Docker & Cloud Ready** - Optimized for high-performance delivery.

## 🛠️ Tech Stack

- **Framework**: [Flutter 3.41+](https://flutter.dev) (Web)
- **Language**: [Dart](https://dart.dev)
- **Navigation**: [go_router](https://pub.dev/packages/go_router)
- **Styling**: Custom Design System with Google Fonts (Inter)
- **Infrastructure**: Docker, Nginx, Google Cloud Run, Firebase Hosting

## 🚀 Getting Started

### Local Development

1. **Install Flutter SDK**:
   - Download the latest stable Flutter SDK.
   - Install at `C:\sazal\flutter` (or your preferred path).
   - Add `flutter\bin` to your system PATH.

2. **Clone and Run**:
   ```powershell
   # Navigate to project
   cd c:\sazal\the-ovens-secret_flutter

   # Install dependencies
   flutter pub get

   # Run in Chrome
   flutter run -d chrome --web-port=8080
   ```

### Docker Deployment (Local)

1. **Build and Start**:
   ```powershell
   .\start-production.ps1
   ```

2. **Access**:
   - http://localhost

## 📋 PowerShell Management Scripts

| Script | Description |
|--------|-------------|
| `.\start-production.ps1` | Build and start the production server |
| `.\stop-server.ps1` | Stop and remove production containers |
| `.\restart-server.ps1` | Restart the application |
| `.\view-logs.ps1` | View real-time server logs |
| `.\backup-site.ps1` | Create a compressed backup of the site |
| `.\health-check.ps1` | Monitor site availability and resources |
| `.\renew-ssl.ps1` | Renew Let's Encrypt certificates |
| `.\update-duckdns.ps1` | Update dynamic DNS (DuckDNS) |

## 📁 Project Structure

```
├── lib/
│   ├── main.dart             # App entry & configuration
│   ├── router/               # Navigation routing
│   ├── theme/                # Design system & tokens
│   ├── data/                 # Menu, Recipes, and Business data
│   ├── components/           # Reusable UI widgets
│   └── pages/                # Distinct application pages
├── assets/images/            # Product gallery & branding
├── web/                      # Web-specific files (index.html, SEO)
├── Dockerfile                # Multi-stage Nginx build
├── nginx.conf                # Web server & security config
└── docker-compose.prod.yml   # Production stack definition
```

---

Made with ❤️ for artisan baking enthusiasts.
© 2026 The Ovens Secret. All rights reserved.
