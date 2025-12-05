#!/bin/bash

################################################################################
#                                                                              #
#  TELEGRAM YOUTUBE DOWNLOADER BOT - NATIVE INSTALLATION (NO DOCKER)         #
#                                                                              #
#  Description:                                                                #
#    Automated installer for a Telegram bot that downloads YouTube videos     #
#    WITHOUT Docker - runs directly on Ubuntu with systemd.                   #
#                                                                              #
#  Benefits over Docker:                                                       #
#    ✅ Much lower RAM usage (100-150 MB less)                                #
#    ✅ Faster startup and execution                                          #
#    ✅ Direct file system access (no volumes)                                #
#    ✅ Simpler management with systemd                                       #
#    ✅ Lower CPU overhead                                                     #
#                                                                              #
#  Features:                                                                   #
#    ✅ Multiple quality selection (360p - 1080p)                             #
#    ✅ Real-time download progress bar                                       #
#    ✅ Video title display with copyable text                                #
#    ✅ Cookie support for authentication                                     #
#    ✅ User whitelist for access control                                     #
#    ✅ Storage cleanup command                                               #
#    ✅ Direct HTTP download links                                            #
#    ✅ Auto-start on boot with systemd                                       #
#                                                                              #
#  Prerequisites:                                                              #
#    - Fresh Ubuntu server (20.04 or newer) with root access                  #
#    - Telegram bot token from @BotFather                                     #
#    - Your Telegram User ID (get from @userinfobot)                          #
#    - Public IP address (auto-detected)                                      #
#    - At least 1GB RAM (500MB for bot, 500MB for downloads)                  #
#                                                                              #
#  Installation:                                                               #
#    1. Create script file:                                                    #
#       nano setup-telegram-bot-native.sh                                     #
#       (paste this content and save)                                         #
#                                                                              #
#    2. Make executable:                                                       #
#       chmod +x setup-telegram-bot-native.sh                                 #
#                                                                              #
#    3. Run as root:                                                           #
#       sudo bash setup-telegram-bot-native.sh                                #
#                                                                              #
#    4. Follow the prompts:                                                    #
#       - Enter your Telegram bot token                                       #
#       - Enter authorized user IDs (comma-separated) or leave empty          #
#       - Confirm server IP address                                           #
#                                                                              #
#    5. Wait for installation (2-3 minutes)                                    #
#                                                                              #
#  File Locations After Installation:                                          #
#    - Bot code: /opt/telegram-yt-bot/bot.py                                  #
#    - Python venv: /opt/telegram-yt-bot/venv/                                #
#    - Downloads: /var/www/telegram-downloads/                                #
#    - Nginx config: /etc/nginx/sites-available/telegram-downloads            #
#    - Systemd service: /etc/systemd/system/telegram-yt-bot.service           #
#    - Cookies (if uploaded): /opt/telegram-yt-bot/cookies.txt                #
#                                                                              #
#  Management Commands:                                                        #
#    - Check status:                                                           #
#      systemctl status telegram-yt-bot                                       #
#                                                                              #
#    - View live logs:                                                         #
#      journalctl -u telegram-yt-bot -f                                       #
#                                                                              #
#    - Restart bot:                                                            #
#      systemctl restart telegram-yt-bot                                      #
#                                                                              #
#    - Stop bot:                                                               #
#      systemctl stop telegram-yt-bot                                         #
#                                                                              #
#    - Start bot:                                                              #
#      systemctl start telegram-yt-bot                                        #
#                                                                              #
#    - Disable auto-start:                                                     #
#      systemctl disable telegram-yt-bot                                      #
#                                                                              #
#    - Enable auto-start:                                                      #
#      systemctl enable telegram-yt-bot                                       #
#                                                                              #
#  Editing Bot Code:                                                           #
#    1. Edit the file:                                                         #
#       nano /opt/telegram-yt-bot/bot.py                                      #
#                                                                              #
#    2. Save changes (Ctrl+O, Enter, Ctrl+X)                                  #
#                                                                              #
#    3. Restart bot:                                                           #
#       systemctl restart telegram-yt-bot                                     #
#                                                                              #
#    4. Check if running:                                                      #
#       systemctl status telegram-yt-bot                                      #
#                                                                              #
#  Storage Management:                                                         #
#    - Check download folder size:                                             #
#      du -sh /var/www/telegram-downloads/                                    #
#                                                                              #
#    - List files with sizes:                                                  #
#      ls -lh /var/www/telegram-downloads/                                    #
#                                                                              #
#    - Count files:                                                            #
#      ls /var/www/telegram-downloads/ | wc -l                                #
#                                                                              #
#    - Manual cleanup (delete all):                                            #
#      rm -rf /var/www/telegram-downloads/*                                   #
#                                                                              #
#    - Or use bot command: /cleanup                                            #
#                                                                              #
#  Bot Commands:                                                               #
#    /start - Show welcome message and bot status                             #
#    /setcookie - Upload YouTube cookies.txt for authentication               #
#    /removecookie - Remove stored cookies                                    #
#    /cleanup - Delete all downloaded files (requires confirmation)           #
#                                                                              #
#  Usage:                                                                      #
#    1. Send /start to your bot in Telegram                                   #
#    2. Send a YouTube video URL                                               #
#    3. Select desired quality from inline buttons                            #
#    4. Watch real-time progress bar during download                          #
#    5. Receive HTTP link with video title (copyable text)                    #
#    6. Download file via browser or download manager                         #
#                                                                              #
#  Cookie Setup (if YouTube blocks or requires login):                        #
#    1. Install browser extension:                                             #
#       - Chrome: "Get cookies.txt LOCALLY"                                   #
#       - Firefox: "cookies.txt"                                              #
#                                                                              #
#    2. Visit youtube.com and login to your account                           #
#                                                                              #
#    3. Click extension icon and export cookies.txt                           #
#                                                                              #
#    4. Send /setcookie to bot                                                 #
#                                                                              #
#    5. Upload the cookies.txt file as Document                               #
#                                                                              #
#    6. Try downloading again                                                  #
#                                                                              #
#  Troubleshooting:                                                            #
#    - Bot not responding:                                                     #
#      systemctl status telegram-yt-bot                                       #
#      journalctl -u telegram-yt-bot -n 50                                    #
#                                                                              #
#    - Port 8080 already in use:                                               #
#      netstat -tulpn | grep 8080                                             #
#      (stop conflicting service or change port in script)                    #
#                                                                              #
#    - Permission errors:                                                      #
#      chmod -R 755 /opt/telegram-yt-bot/                                     #
#      chmod -R 755 /var/www/telegram-downloads/                              #
#                                                                              #
#    - Python packages issues:                                                 #
#      source /opt/telegram-yt-bot/venv/bin/activate                          #
#      pip install --upgrade -r /opt/telegram-yt-bot/requirements.txt        #
#      deactivate                                                              #
#      systemctl restart telegram-yt-bot                                      #
#                                                                              #
#  Uninstallation:                                                             #
#    1. Stop and disable service:                                              #
#       systemctl stop telegram-yt-bot                                        #
#       systemctl disable telegram-yt-bot                                     #
#                                                                              #
#    2. Remove files:                                                          #
#       rm -rf /opt/telegram-yt-bot/                                          #
#       rm -rf /var/www/telegram-downloads/                                   #
#       rm /etc/systemd/system/telegram-yt-bot.service                        #
#       rm /etc/nginx/sites-enabled/telegram-downloads                        #
#       rm /etc/nginx/sites-available/telegram-downloads                      #
#                                                                              #
#    3. Reload services:                                                       #
#       systemctl daemon-reload                                               #
#       systemctl restart nginx                                               #
#                                                                              #
#    4. Optional - remove packages:                                            #
#       apt remove python3-pip python3-venv ffmpeg nginx                      #
#                                                                              #
#  Security Notes:                                                             #
#    - Always use whitelist (enter your User ID during setup)                 #
#    - Don't share your bot token publicly                                    #
#    - Downloaded files are accessible via HTTP (not HTTPS)                   #
#    - Consider adding firewall rules to restrict port 8080                   #
#    - Regularly cleanup old downloads to save disk space                     #
#                                                                              #
#  Performance:                                                                #
#    - RAM usage: ~100-200 MB (vs 300-400 MB with Docker)                     #
#    - CPU usage: Minimal when idle, high during download/encoding            #
#    - Disk space: Depends on downloads (use /cleanup regularly)              #
#    - Network: Uses full server bandwidth for downloads                      #
#                                                                              #
#  Support & Resources:                                                        #
#    - Python Telegram Bot: https://python-telegram-bot.org/                 #
#    - yt-dlp: https://github.com/yt-dlp/yt-dlp                              #
#    - Nginx: https://nginx.org/en/docs/                                      #
#    - Systemd: https://www.freedesktop.org/software/systemd/man/            #
#                                                                              #
#  Version: 2.0 (Native - No Docker)                                          #
#  Last Updated: December 2025                                                #
#                                                                              #
################################################################################

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Telegram YT Bot - Native Installation${NC}"
echo -e "${BLUE}  (No Docker - Direct systemd deployment)${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}❌ Please run as root: sudo bash setup-telegram-bot-native.sh${NC}"
    exit 1
fi

# Get Telegram bot token
echo -e "${YELLOW}📱 Enter your Telegram bot token:${NC}"
echo -e "${YELLOW}   (Get it from @BotFather using /newbot command)${NC}"
read -p "Token: " TELEGRAM_TOKEN

if [ -z "$TELEGRAM_TOKEN" ]; then
    echo -e "${RED}❌ Token cannot be empty!${NC}"
    exit 1
fi

# Get authorized user IDs
echo ""
echo -e "${YELLOW}👥 Enter authorized Telegram User IDs (comma-separated):${NC}"
echo -e "${YELLOW}   Example: 123456789,987654321${NC}"
echo -e "${YELLOW}   To find your User ID, message @userinfobot${NC}"
echo -e "${YELLOW}   Leave empty to allow everyone (not recommended)${NC}"
read -p "User IDs: " USER_IDS_INPUT

# Process user IDs
if [ -z "$USER_IDS_INPUT" ]; then
    ALLOWED_USERS_ARRAY="[]"
    echo -e "${RED}⚠️  WARNING: No whitelist - Bot will be public!${NC}"
else
    IFS=',' read -ra USER_IDS <<< "$USER_IDS_INPUT"
    ALLOWED_USERS_ARRAY="["
    for i in "${!USER_IDS[@]}"; do
        USER_ID=$(echo "${USER_IDS[$i]}" | xargs)
        ALLOWED_USERS_ARRAY+="$USER_ID"
        if [ $i -lt $((${#USER_IDS[@]} - 1)) ]; then
            ALLOWED_USERS_ARRAY+=", "
        fi
    done
    ALLOWED_USERS_ARRAY+="]"
    echo -e "${GREEN}✅ Whitelist configured with ${#USER_IDS[@]} user(s)${NC}"
fi

# Get server IP
echo ""
echo -e "${YELLOW}🌐 Detecting public server IP...${NC}"
SERVER_IP=$(curl -s ifconfig.me)
echo -e "${GREEN}✅ Your server IP: $SERVER_IP${NC}"
echo ""
read -p "Press Enter to confirm or type new IP address: " NEW_IP

if [ ! -z "$NEW_IP" ]; then
    SERVER_IP=$NEW_IP
    echo -e "${GREEN}✅ IP updated to: $SERVER_IP${NC}"
fi

# Install system dependencies
echo ""
echo -e "${BLUE}📦 Installing system dependencies...${NC}"
apt update -qq
apt install -y python3 python3-pip python3-venv ffmpeg nginx curl > /dev/null 2>&1
echo -e "${GREEN}✅ System dependencies installed${NC}"

# Create project structure
echo ""
echo -e "${BLUE}📁 Creating project structure...${NC}"
mkdir -p /opt/telegram-yt-bot
mkdir -p /var/www/telegram-downloads
cd /opt/telegram-yt-bot

# Create Python virtual environment
echo -e "${BLUE}🐍 Setting up Python virtual environment...${NC}"
python3 -m venv venv
source venv/bin/activate

# Create requirements.txt
cat > requirements.txt << 'EOF'
python-telegram-bot==20.7
yt-dlp
aiohttp
EOF

# Install Python packages
echo -e "${BLUE}📚 Installing Python packages...${NC}"
pip install -q --no-cache-dir -r requirements.txt
echo -e "${GREEN}✅ Python packages installed${NC}"

# Create bot.py
echo -e "${BLUE}🤖 Creating bot application...${NC}"
cat > bot.py << 'ENDOFFILE'
import os
import asyncio
import logging
import hashlib
import time
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, CallbackQueryHandler, ContextTypes, filters
import yt_dlp
import json

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

DOWNLOAD_PATH = "/var/www/telegram-downloads"
COOKIE_PATH = "/opt/telegram-yt-bot/cookies.txt"
SERVER_URL = os.getenv("SERVER_URL", "http://localhost:8080")
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")

url_cache = {}

ALLOWED_USERS = PLACEHOLDER_ALLOWED_USERS

def is_authorized(user_id: int) -> bool:
    if not ALLOWED_USERS:
        return True
    return user_id in ALLOWED_USERS

async def unauthorized_message(update: Update):
    await update.message.reply_text(
        "❌ Access Denied\n\n"
        "You are not authorized to use this bot.\n\n"
        f"Your User ID: \`{update.effective_user.id}\`\n"
        "Contact the bot owner to request access.",
        parse_mode='Markdown'
    )

def get_url_id(url):
    return hashlib.md5(url.encode()).hexdigest()[:8]

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not is_authorized(update.effective_user.id):
        logger.warning(f"Unauthorized access attempt by user {update.effective_user.id}")
        await unauthorized_message(update)
        return
    
    cookie_status = "✅ Cookie active" if os.path.exists(COOKIE_PATH) else "❌ No cookie"
    
    await update.message.reply_text(
        "Hello! 👋\n\n"
        "🎬 Send me a YouTube link and I'll show you available quality options.\n\n"
        "🍪 To upload cookies (if you get errors): /setcookie\n"
        "🗑 To remove cookies: /removecookie\n"
        "🧹 To cleanup all downloads: /cleanup\n\n"
        f"Status: {cookie_status}"
    )

async def setcookie_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not is_authorized(update.effective_user.id):
        logger.warning(f"Unauthorized access attempt by user {update.effective_user.id}")
        await unauthorized_message(update)
        return
    
    await update.message.reply_text(
        "🍪 Please send the cookies.txt file as a Document.\n\n"
        "📖 How to get cookies:\n"
        "1️⃣ Install browser extension:\n"
        "   • Chrome: Get cookies.txt LOCALLY\n"
        "   • Firefox: cookies.txt\n"
        "2️⃣ Go to youtube.com and login\n"
        "3️⃣ Click on the extension icon\n"
        "4️⃣ Download the cookies.txt file\n"
        "5️⃣ Send it here"
    )

async def removecookie_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not is_authorized(update.effective_user.id):
        await unauthorized_message(update)
        return
    
    if os.path.exists(COOKIE_PATH):
        os.remove(COOKIE_PATH)
        await update.message.reply_text("✅ Cookie removed successfully.")
    else:
        await update.message.reply_text("❌ No cookie found.")

async def cleanup_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not is_authorized(update.effective_user.id):
        await unauthorized_message(update)
        return
    
    try:
        files = os.listdir(DOWNLOAD_PATH)
        file_count = len(files)
        
        if file_count == 0:
            await update.message.reply_text("✅ No files to clean. Storage is already empty.")
            return
        
        total_size = 0
        for filename in files:
            filepath = os.path.join(DOWNLOAD_PATH, filename)
            if os.path.isfile(filepath):
                total_size += os.path.getsize(filepath)
        
        size_mb = total_size / (1024 * 1024)
        size_gb = total_size / (1024 * 1024 * 1024)
        
        if size_gb >= 1:
            size_str = f"{size_gb:.2f} GB"
        else:
            size_str = f"{size_mb:.2f} MB"
        
        await update.message.reply_text(
            f"🗑 Found {file_count} file(s)\n"
            f"📦 Total size: {size_str}\n\n"
            f"⚠️ Are you sure you want to delete all files?\n"
            f"Reply with 'yes' to confirm or anything else to cancel."
        )
        
        context.user_data['cleanup_pending'] = True
        
    except Exception as e:
        logger.error(f"Cleanup error: {e}")
        await update.message.reply_text(f"❌ Error checking files: {str(e)}")

async def handle_cleanup_confirmation(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not context.user_data.get('cleanup_pending'):
        return False
    
    if not is_authorized(update.effective_user.id):
        return False
    
    user_response = update.message.text.strip().lower()
    
    if user_response == 'yes':
        try:
            files = os.listdir(DOWNLOAD_PATH)
            deleted_count = 0
            
            for filename in files:
                filepath = os.path.join(DOWNLOAD_PATH, filename)
                if os.path.isfile(filepath):
                    os.remove(filepath)
                    deleted_count += 1
            
            await update.message.reply_text(
                f"✅ Cleanup complete!\n\n"
                f"🗑 Deleted {deleted_count} file(s)\n"
                f"💾 Storage space freed"
            )
            
            logger.info(f"User {update.effective_user.id} cleaned up {deleted_count} files")
            
        except Exception as e:
            logger.error(f"Cleanup execution error: {e}")
            await update.message.reply_text(f"❌ Error during cleanup: {str(e)}")
    else:
        await update.message.reply_text("❌ Cleanup cancelled.")
    
    context.user_data['cleanup_pending'] = False
    return True

async def handle_document(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not is_authorized(update.effective_user.id):
        await unauthorized_message(update)
        return
    
    document = update.message.document
    
    if not document.file_name.endswith('.txt'):
        await update.message.reply_text("❌ Please send only .txt files.")
        return
    
    try:
        file = await context.bot.get_file(document.file_id)
        await file.download_to_drive(COOKIE_PATH)
        
        with open(COOKIE_PATH, 'r') as f:
            content = f.read()
            if 'youtube.com' not in content and 'google.com' not in content:
                os.remove(COOKIE_PATH)
                await update.message.reply_text("❌ Invalid cookie file.")
                return
        
        await update.message.reply_text("✅ Cookie saved successfully!\n\nYou can now send YouTube links.")
        
    except Exception as e:
        logger.error(f"Cookie upload error: {e}")
        await update.message.reply_text(f"❌ Error saving cookie: {str(e)}")

async def handle_url(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if await handle_cleanup_confirmation(update, context):
        return
    
    if not is_authorized(update.effective_user.id):
        await unauthorized_message(update)
        return
    
    url = update.message.text.strip()
    
    if not ("youtube.com" in url or "youtu.be" in url):
        await update.message.reply_text("❌ Please send a valid YouTube link.")
        return
    
    msg = await update.message.reply_text("⏳ Fetching video info...")
    
    try:
        ydl_opts = {'quiet': True, 'no_warnings': True, 'extract_flat': False}
        
        if os.path.exists(COOKIE_PATH):
            ydl_opts['cookiefile'] = COOKIE_PATH
        
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=False)
            
        formats = {}
        
        for f in info.get('formats', []):
            height = f.get('height')
            format_id = f.get('format_id')
            vcodec = f.get('vcodec', 'none')
            
            if height and format_id and vcodec != 'none':
                quality_key = f"{height}p"
                if quality_key not in formats:
                    formats[quality_key] = {
                        'format_id': format_id,
                        'quality': quality_key,
                        'ext': f.get('ext', 'mp4')
                    }
        
        format_list = list(formats.values())
        format_list.sort(key=lambda x: int(x['quality'].replace('p', '')), reverse=True)
        
        if not format_list:
            await msg.edit_text("❌ No video formats found.")
            return
        
        url_id = get_url_id(url)
        video_title = info.get('title', 'Video')
        
        keyboard = []
        for fmt in format_list[:10]:
            cache_key = f"{url_id}:{fmt['format_id']}"
            url_cache[cache_key] = {'url': url, 'quality': fmt['quality'], 'title': video_title}
            
            callback_data = json.dumps({'id': url_id, 'fmt': fmt['format_id']})
            keyboard.append([InlineKeyboardButton(f"📹 {fmt['quality']} ({fmt['ext']})", callback_data=callback_data)])
        
        reply_markup = InlineKeyboardMarkup(keyboard)
        await msg.edit_text(f"📺 *{video_title}*\n\nSelect quality:", parse_mode='Markdown', reply_markup=reply_markup)
        
    except Exception as e:
        error_msg = str(e)
        logger.error(f"Error: {error_msg}")
        
        if "Sign in to confirm" in error_msg or "bot" in error_msg.lower():
            await msg.edit_text("❌ YouTube requires authentication.\n\nTo fix this:\n1️⃣ Send /setcookie command\n2️⃣ Upload your cookie file")
        else:
            await msg.edit_text(f"❌ Error: {error_msg}")

async def handle_callback(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    
    if not is_authorized(query.from_user.id):
        await query.answer("❌ Access Denied", show_alert=True)
        return
    
    await query.answer()
    
    try:
        data = json.loads(query.data)
        url_id = data['id']
        format_id = data['fmt']
        
        cache_key = f"{url_id}:{format_id}"
        cached_data = url_cache.get(cache_key)
        
        if not cached_data:
            await query.edit_message_text("❌ Link expired, please send again.")
            return
        
        url = cached_data['url']
        quality = cached_data['quality']
        video_title = cached_data.get('title', 'Video')
        
        await query.edit_message_text("⬇️ Download started, please wait...")
        
        filename = f"{int(time.time() * 1000)}.mp4"
        filepath = os.path.join(DOWNLOAD_PATH, filename)
        
        height = quality.replace('p', '')
        
        progress_state = {'last_percent': 0, 'last_update': 0}
        
        def progress_hook(d):
            if d['status'] == 'downloading':
                current_time = time.time()
                if current_time - progress_state['last_update'] < 3:
                    return
                
                downloaded = d.get('downloaded_bytes', 0)
                total = d.get('total_bytes') or d.get('total_bytes_estimate', 0)
                
                if total > 0:
                    percent = int((downloaded / total) * 100)
                    if abs(percent - progress_state['last_percent']) < 5:
                        return
                    
                    progress_state['last_percent'] = percent
                    progress_state['last_update'] = current_time
                    
                    bar_length = 10
                    filled = int(bar_length * percent // 100)
                    bar = '█' * filled + '░' * (bar_length - filled)
                    
                    speed = d.get('speed', 0)
                    speed_mb = speed / (1024 * 1024) if speed else 0
                    downloaded_mb = downloaded / (1024 * 1024)
                    total_mb = total / (1024 * 1024)
                    
                    progress_text = f"⬇️ Downloading...\n\n{bar} {percent}%\n\n📦 {downloaded_mb:.1f} MB / {total_mb:.1f} MB\n⚡ Speed: {speed_mb:.1f} MB/s"
                    progress_state['pending_text'] = progress_text
        
        async def update_progress():
            while True:
                await asyncio.sleep(3)
                if 'pending_text' in progress_state:
                    try:
                        await context.bot.edit_message_text(
                            chat_id=query.message.chat_id,
                            message_id=query.message.message_id,
                            text=progress_state['pending_text']
                        )
                        del progress_state['pending_text']
                    except Exception:
                        pass
                
                if progress_state.get('done'):
                    break
        
        progress_task = asyncio.create_task(update_progress())
        
        try:
            ydl_opts = {
                'format': f'{format_id}+bestaudio[ext=m4a]/{format_id}+bestaudio/bestvideo[height<={height}]+bestaudio/best[height<={height}]/best',
                'outtmpl': filepath,
                'merge_output_format': 'mp4',
                'progress_hooks': [progress_hook],
            }
            
            if os.path.exists(COOKIE_PATH):
                ydl_opts['cookiefile'] = COOKIE_PATH
            
            loop = asyncio.get_event_loop()
            await loop.run_in_executor(None, lambda: yt_dlp.YoutubeDL(ydl_opts).download([url]))
        finally:
            progress_state['done'] = True
            await asyncio.sleep(1)
            progress_task.cancel()
        
        download_link = f"{SERVER_URL}/downloads/{filename}"
        
        await context.bot.edit_message_text(
            chat_id=query.message.chat_id,
            message_id=query.message.message_id,
            text=(
                f"✅ Download complete!\n\n"
                f"📺 Title:\n"
                f"`{video_title}`"
                f"\n\n"
                f"🔗 Download link:\n"
                f"`{download_link}`"
                f"\n\n"
                f"⚠️ This link is valid while the server is running."
            ),
            parse_mode='Markdown'
        )
        
        url_cache.pop(cache_key, None)
        
    except Exception as e:
        logger.error(f"Download error: {e}")
        try:
            await context.bot.edit_message_text(
                chat_id=query.message.chat_id,
                message_id=query.message.message_id,
                text=f"❌ Download error: {str(e)}"
            )
        except Exception:
            pass

def main():
    if not TELEGRAM_BOT_TOKEN:
        raise ValueError("TELEGRAM_BOT_TOKEN not set!")
    
    if ALLOWED_USERS:
        logger.info(f"Whitelist enabled with {len(ALLOWED_USERS)} authorized user(s)")
    else:
        logger.warning("Whitelist is EMPTY - Bot is accessible to everyone!")
    
    app = Application.builder().token(TELEGRAM_BOT_TOKEN).build()
    
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("setcookie", setcookie_command))
    app.add_handler(CommandHandler("removecookie", removecookie_command))
    app.add_handler(CommandHandler("cleanup", cleanup_command))
    app.add_handler(MessageHandler(filters.Document.ALL, handle_document))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_url))
    app.add_handler(CallbackQueryHandler(handle_callback))
    
    logger.info("Bot started!")
    app.run_polling(allowed_updates=Update.ALL_TYPES)

if __name__ == "__main__":
    main()
ENDOFFILE

# Replace placeholder with actual user IDs
sed -i "s/PLACEHOLDER_ALLOWED_USERS/$ALLOWED_USERS_ARRAY/" bot.py
echo -e "${GREEN}✅ Bot application created${NC}"

# Configure Nginx
echo ""
echo -e "${BLUE}🌐 Configuring Nginx web server...${NC}"
cat > /etc/nginx/sites-available/telegram-downloads << EOF
server {
    listen 8080;
    server_name _;
    
    location /downloads/ {
        alias /var/www/telegram-downloads/;
        autoindex off;
        
        add_header Content-Disposition 'attachment';
        add_header X-Content-Type-Options nosniff;
    }
    
    location / {
        return 404;
    }
}
EOF

ln -sf /etc/nginx/sites-available/telegram-downloads /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t > /dev/null 2>&1 && systemctl restart nginx
echo -e "${GREEN}✅ Nginx configured${NC}"

# Create systemd service
echo ""
echo -e "${BLUE}⚙️  Creating systemd service...${NC}"
cat > /etc/systemd/system/telegram-yt-bot.service << EOF
[Unit]
Description=Telegram YouTube Downloader Bot
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/telegram-yt-bot
Environment="TELEGRAM_BOT_TOKEN=$TELEGRAM_TOKEN"
Environment="SERVER_URL=http://$SERVER_IP:8080"
ExecStart=/opt/telegram-yt-bot/venv/bin/python /opt/telegram-yt-bot/bot.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable telegram-yt-bot > /dev/null 2>&1
systemctl start telegram-yt-bot
echo -e "${GREEN}✅ Systemd service created and started${NC}"

# Wait for bot to start
sleep 3

# Check if bot is running
if systemctl is-active --quiet telegram-yt-bot; then
    BOT_STATUS="${GREEN}✅ Running${NC}"
else
    BOT_STATUS="${RED}❌ Failed to start${NC}"
fi

# Final output
echo ""
echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}  ✅ Installation completed successfully!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo -e "${YELLOW}📱 Your Telegram bot is ready!${NC}"
echo -e "   Bot status: $BOT_STATUS"
echo ""
if [ "$ALLOWED_USERS_ARRAY" != "[]" ]; then
    echo -e "${GREEN}🔒 Whitelist enabled - Only authorized users can access${NC}"
else
    echo -e "${RED}⚠️  No whitelist - Bot is public!${NC}"
fi
echo ""
echo -e "${BLUE}📋 Quick Commands:${NC}"
echo -e "  • Check status: ${GREEN}systemctl status telegram-yt-bot${NC}"
echo -e "  • View logs: ${GREEN}journalctl -u telegram-yt-bot -f${NC}"
echo -e "  • Restart bot: ${GREEN}systemctl restart telegram-yt-bot${NC}"
echo -e "  • Stop bot: ${GREEN}systemctl stop telegram-yt-bot${NC}"
echo ""
echo -e "${BLUE}📂 Important Locations:${NC}"
echo -e "  • Bot code: ${GREEN}/opt/telegram-yt-bot/bot.py${NC}"
echo -e "  • Downloads: ${GREEN}/var/www/telegram-downloads/${NC}"
echo -e "  • Check size: ${GREEN}du -sh /var/www/telegram-downloads/${NC}"
echo ""
echo -e "${BLUE}✏️  To edit bot:${NC}"
echo -e "  1. ${GREEN}nano /opt/telegram-yt-bot/bot.py${NC}"
echo -e "  2. Make changes and save (Ctrl+O, Enter, Ctrl+X)"
echo -e "  3. ${GREEN}systemctl restart telegram-yt-bot${NC}"
echo ""
echo -e "${YELLOW}⚠️  If you get 'Sign in' error when downloading:${NC}"
echo -e "  1. Send ${GREEN}/setcookie${NC} to the bot"
echo -e "  2. Upload cookies.txt from your browser"
echo ""
