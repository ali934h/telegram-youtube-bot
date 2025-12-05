# Telegram YouTube Downloader Bot

🤖 **Native Installation** - No Docker Required

A powerful Telegram bot that downloads YouTube videos directly on your Ubuntu server with systemd management. Optimized for minimal resource usage and maximum performance.

## 🌟 Key Features

✅ **Multiple Quality Options** - 360p to 1080p video selection  
✅ **Real-time Progress Bar** - Live download status updates  
✅ **Video Metadata Display** - Copyable video titles and links  
✅ **Cookie Support** - Bypass YouTube authentication requirements  
✅ **User Whitelist** - Access control for authorized users only  
✅ **Storage Management** - Built-in cleanup command  
✅ **HTTP Download Links** - Direct browser-downloadable links  
✅ **Auto-start on Boot** - Systemd service integration  
✅ **Low Resource Usage** - 100-150MB less RAM than Docker version  

## 📋 Prerequisites

- **Ubuntu Server** 20.04 or newer
- **Root Access** (sudo privileges)
- **Telegram Bot Token** (from [@BotFather](https://t.me/BotFather))
- **Your Telegram User ID** (from [@userinfobot](https://t.me/userinfobot))
- **Public IP Address** (auto-detected during setup)
- **At Least 1GB RAM** (500MB for bot, 500MB for downloads)

## 🚀 Quick Installation

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/ali934h/telegram-youtube-bot/main/setup-telegram-bot-native.sh | sudo bash
```

### Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ali934h/telegram-youtube-bot.git
   cd telegram-youtube-bot
   ```

2. **Make the script executable:**
   ```bash
   chmod +x setup-telegram-bot-native.sh
   ```

3. **Run the installer:**
   ```bash
   sudo bash setup-telegram-bot-native.sh
   ```

4. **Follow the prompts:**
   - Enter your Telegram bot token
   - Enter authorized user IDs (comma-separated) or leave empty
   - Confirm your server IP address

5. **Wait for installation** (typically 2-3 minutes)

## 💬 Bot Commands

| Command | Description |
|---------|-------------|
| `/start` | Show welcome message and bot status |
| `/setcookie` | Upload YouTube cookies.txt for authentication |
| `/removecookie` | Remove stored cookies |
| `/cleanup` | Delete all downloaded files (requires confirmation) |

## 📖 Usage Guide

1. **Start your bot** in Telegram with `/start`
2. **Send a YouTube video URL**
3. **Select desired quality** from inline buttons
4. **Watch real-time progress** during download
5. **Receive HTTP download link** with video title
6. **Download the file** via browser or download manager

## 🍪 Cookie Setup (Optional)

If YouTube blocks downloads or requires authentication:

1. **Install browser extension:**
   - Chrome: "Get cookies.txt LOCALLY"
   - Firefox: "cookies.txt"

2. **Visit youtube.com** and login to your account

3. **Export cookies.txt** using the extension

4. **Send `/setcookie`** to your bot

5. **Upload the cookies.txt file** as Document

6. **Try downloading again**

## 🛠️ Management Commands

### Check Bot Status
```bash
systemctl status telegram-yt-bot
```

### View Live Logs
```bash
journalctl -u telegram-yt-bot -f
```

### Restart Bot
```bash
systemctl restart telegram-yt-bot
```

### Stop Bot
```bash
systemctl stop telegram-yt-bot
```

### Start Bot
```bash
systemctl start telegram-yt-bot
```

### Disable Auto-start
```bash
systemctl disable telegram-yt-bot
```

### Enable Auto-start
```bash
systemctl enable telegram-yt-bot
```

## 📂 File Locations

| Component | Location |
|-----------|----------|
| Bot Code | `/opt/telegram-yt-bot/bot.py` |
| Python venv | `/opt/telegram-yt-bot/venv/` |
| Downloads | `/var/www/telegram-downloads/` |
| Nginx Config | `/etc/nginx/sites-available/telegram-downloads` |
| Systemd Service | `/etc/systemd/system/telegram-yt-bot.service` |
| Cookies | `/opt/telegram-yt-bot/cookies.txt` |

## ✏️ Editing Bot Code

1. **Edit the bot file:**
   ```bash
   nano /opt/telegram-yt-bot/bot.py
   ```

2. **Save changes** (Ctrl+O, Enter, Ctrl+X)

3. **Restart the bot:**
   ```bash
   systemctl restart telegram-yt-bot
   ```

4. **Check status:**
   ```bash
   systemctl status telegram-yt-bot
   ```

## 💾 Storage Management

### Check Download Folder Size
```bash
du -sh /var/www/telegram-downloads/
```

### List Files with Sizes
```bash
ls -lh /var/www/telegram-downloads/
```

### Count Files
```bash
ls /var/www/telegram-downloads/ | wc -l
```

### Manual Cleanup (Delete All)
```bash
rm -rf /var/www/telegram-downloads/*
```

Or use the bot command: `/cleanup`

## 🔧 Troubleshooting

### Bot Not Responding
```bash
systemctl status telegram-yt-bot
journalctl -u telegram-yt-bot -n 50
```

### Port 8080 Already in Use
```bash
netstat -tulpn | grep 8080
# Stop conflicting service or change port in script
```

### Permission Errors
```bash
chmod -R 755 /opt/telegram-yt-bot/
chmod -R 755 /var/www/telegram-downloads/
```

### Python Package Issues
```bash
source /opt/telegram-yt-bot/venv/bin/activate
pip install --upgrade -r /opt/telegram-yt-bot/requirements.txt
deactivate
systemctl restart telegram-yt-bot
```

## 🗑️ Uninstallation

1. **Stop and disable service:**
   ```bash
   systemctl stop telegram-yt-bot
   systemctl disable telegram-yt-bot
   ```

2. **Remove files:**
   ```bash
   rm -rf /opt/telegram-yt-bot/
   rm -rf /var/www/telegram-downloads/
   rm /etc/systemd/system/telegram-yt-bot.service
   rm /etc/nginx/sites-enabled/telegram-downloads
   rm /etc/nginx/sites-available/telegram-downloads
   ```

3. **Reload services:**
   ```bash
   systemctl daemon-reload
   systemctl restart nginx
   ```

4. **Optional - remove packages:**
   ```bash
   apt remove python3-pip python3-venv ffmpeg nginx
   ```

## 🔒 Security Notes

- Always use the **user whitelist** feature (enter your User ID during setup)
- **Don't share** your bot token publicly
- Downloaded files are accessible via **HTTP** (not HTTPS by default)
- Consider adding **firewall rules** to restrict port 8080
- **Regularly cleanup** old downloads to save disk space

## 📊 Performance

- **RAM Usage:** ~100-200 MB (vs 300-400 MB with Docker)
- **CPU Usage:** Minimal when idle, high during download/encoding
- **Disk Space:** Depends on downloads (use `/cleanup` regularly)
- **Network:** Uses full server bandwidth for downloads

## 🎯 Benefits Over Docker

- ✅ Much lower RAM usage (100-150 MB less)
- ✅ Faster startup and execution
- ✅ Direct file system access (no volumes)
- ✅ Simpler management with systemd
- ✅ Lower CPU overhead

## 📚 Resources

- [Python Telegram Bot](https://python-telegram-bot.org/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Systemd Manual](https://www.freedesktop.org/software/systemd/man/)

## 📝 License

MIT License - Feel free to use and modify

## 👨‍💻 Author

**Ali Hosseini**  
- GitHub: [@ali934h](https://github.com/ali934h)
- Website: [alihosseini.dev](https://alihosseini.dev)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## ⭐ Show Your Support

Give a ⭐️ if this project helped you!

---

**Version:** 2.0 (Native - No Docker)  
**Last Updated:** December 2025