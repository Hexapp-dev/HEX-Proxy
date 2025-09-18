<div align="center">
  <h1>HEX Proxy - GitHub Access Solution</h1>
  <p>Easy GitHub access through external servers</p>
  
  <div>
    <a href="#english">🇺🇸 English</a> | 
    <a href="#persian">🇮🇷 فارسی</a>
  </div>
</div>

---

<div id="english">

# HEX Proxy - GitHub Access Solution

## 🚀 Overview

After the recent disruptions and GitHub being blocked in Iran, we've created an easy solution that allows you to maintain your connection to GitHub servers using an external server, just like before.

## 📋 Prerequisites

- A Linux server outside Iran
- SSH access to the server
- Basic terminal knowledge

## 🛠️ Installation

Run the following command to install and configure the proxy:

```bash
bash <(curl -s https://cdn.jsdelivr.net/gh/Hexapp-dev/HEX-Proxy/install.sh)
```

## ⚙️ Configuration

After installation, you'll need to set up the proxy environment variables in your current terminal session:

```bash
export http_proxy="socks5h://127.0.0.1:1080"
export https_proxy="socks5h://127.0.0.1:1080"
```

## 🔄 Session Management

**Important:** If you close your terminal session, you'll need to run the export commands again to re-enable the proxy.

## 🎯 Features

- **Easy Setup**: One-command installation
- **Menu-Driven Interface**: Simple configuration through interactive menu
- **Automatic SSH Tunnel**: Establishes secure SOCKS5 proxy connection
- **Background Operation**: Tunnel runs in background after setup
- **Cross-Platform**: Works on Ubuntu, CentOS, Fedora, Arch Linux, and macOS

## 📱 Menu Options

1. **Configure SSH tunnel** - Set up new proxy connection
2. **Remove SSH tunnel** - Stop existing proxy connection  
3. **Exit** - Close menu (tunnel continues running in background)

## 🧪 Testing

Test your proxy connection:

```bash
curl --proxy socks5h://127.0.0.1:1080 http://httpbin.org/ip
```

## 🔧 Management

- **Stop tunnel**: `kill <PID>` (PID shown when exiting)
- **Check status**: Run the script again to see menu options
- **Restart**: Use menu option 1 to configure a new tunnel

## 🌐 Supported Applications

Once configured, the proxy works with:
- Git operations (clone, push, pull)
- Package managers (apt, yum, dnf, pacman)
- Web browsers (when configured)
- Command-line tools (curl, wget, etc.)

## 📞 Support

- **Website**: https://hexapp.dev
- **Telegram**: https://t.me/HEXApp_dev

## ⚠️ Important Notes

- Keep your server credentials secure
- The proxy only works while the SSH tunnel is active
- Remember to re-export variables after terminal restart
- Ensure your external server has stable internet connection

---

## ⭐ Support Us

If this project helped you, please give us a star! It motivates us to continue improving and adding new features.

---

*Made with ❤️ by HEX Team*

</div>

---

<div id="persian">

# HEX Proxy - راه حل دسترسی به GitHub

## 🚀 معرفی

پس از اختلالاتی که به وجود آمد و فیلتر شدن GitHub در ایران، ما دست به کار شدیم تا راهکاری راحت ایجاد کنیم که شما با داشتن یک سرور خارج بتوانید اتصالتان به سرورهای GitHub را مثل قبل برقرار کنید.

## 📋 پیش‌نیازها

- یک سرور لینوکس خارج از ایران
- دسترسی SSH به سرور
- آشنایی اولیه با ترمینال

## 🛠️ نصب

برای نصب و پیکربندی پروکسی، دستور زیر را اجرا کنید:

```bash
bash <(curl -s https://cdn.jsdelivr.net/gh/Hexapp-dev/HEX-Proxy/install.sh)
```

## ⚙️ پیکربندی

پس از نصب، باید متغیرهای محیطی پروکسی را در جلسه ترمینال فعلی تنظیم کنید:

```bash
export http_proxy="socks5h://127.0.0.1:1080"
export https_proxy="socks5h://127.0.0.1:1080"
```

## 🔄 مدیریت جلسه

**مهم:** اگر جلسه ترمینال خود را ببندید، باید دوباره دستورات export را اجرا کنید تا پروکسی فعال شود.

## 🎯 ویژگی‌ها

- **نصب آسان**: نصب با یک دستور
- **رابط منو محور**: پیکربندی ساده از طریق منوی تعاملی
- **تونل SSH خودکار**: برقراری اتصال پروکسی SOCKS5 امن
- **عملکرد پس‌زمینه**: تونل پس از راه‌اندازی در پس‌زمینه اجرا می‌شود
- **چند پلتفرمه**: روی Ubuntu، CentOS، Fedora، Arch Linux و macOS کار می‌کند

## 📱 گزینه‌های منو

1. **پیکربندی تونل SSH** - راه‌اندازی اتصال پروکسی جدید
2. **حذف تونل SSH** - متوقف کردن اتصال پروکسی موجود
3. **خروج** - بستن منو (تونل در پس‌زمینه ادامه می‌یابد)

## 🧪 تست

اتصال پروکسی خود را تست کنید:

```bash
curl --proxy socks5h://127.0.0.1:1080 http://httpbin.org/ip
```

## 🔧 مدیریت

- **متوقف کردن تونل**: `kill <PID>` (PID هنگام خروج نمایش داده می‌شود)
- **بررسی وضعیت**: اسکریپت را دوباره اجرا کنید تا گزینه‌های منو را ببینید
- **راه‌اندازی مجدد**: از گزینه 1 منو برای پیکربندی تونل جدید استفاده کنید

## 🌐 برنامه‌های پشتیبانی شده

پس از پیکربندی، پروکسی با موارد زیر کار می‌کند:
- عملیات Git (clone، push، pull)
- مدیران بسته (apt، yum، dnf، pacman)
- مرورگرهای وب (هنگام پیکربندی)
- ابزارهای خط فرمان (curl، wget و غیره)

## 📞 پشتیبانی

- **وب‌سایت**: https://hexapp.dev
- **تلگرام**: https://t.me/HEXApp_dev

## ⚠️ نکات مهم

- اطلاعات ورود سرور خود را امن نگه دارید
- پروکسی فقط تا زمانی که تونل SSH فعال است کار می‌کند
- پس از راه‌اندازی مجدد ترمینال، متغیرها را دوباره export کنید
- اطمینان حاصل کنید که سرور خارجی شما اتصال اینترنت پایدار دارد

---

## ⭐ از ما حمایت کنید

اگر این پروژه به شما کمک کرد، لطفاً به ما ستاره بدهید! این کار ما را برای ادامه بهبود و اضافه کردن ویژگی‌های جدید تشویق می‌کند.

---

*ساخته شده با ❤️ توسط تیم HEX*

</div>
