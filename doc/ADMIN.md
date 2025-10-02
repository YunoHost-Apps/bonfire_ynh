## Bonfire Administration

### ⚠️ Email Configuration (Critical)

Bonfire **requires working email** for user signups, password resets, and notifications. Most installations will need email configuration before the instance is usable.

#### Checking Email Status

Test if email is working:
```bash
echo "Test" | mail -s "Test" -r "bonfire@your-domain.tld" your-email@example.com
sudo tail -f /var/log/mail.log
```

#### Common Email Setup (Port 25 Blocked)

If port 25 is blocked (very common), configure an SMTP relay:

**Using Free Email Service (Brevo)**

1. **Create free account** at [Brevo.com](https://www.brevo.com)
   - Free tier: 300 emails/day
   - No credit card required

2. **Get SMTP credentials:**
   - Navigate to: SMTP & API → SMTP settings
   - Copy your SMTP key (NOT your password)

3. **Configure YunoHost relay:**
   ```bash
   sudo yunohost settings set email.relay.enabled -v yes
   sudo yunohost settings set email.relay.host -v "smtp-relay.brevo.com"
   sudo yunohost settings set email.relay.port -v 587
   sudo yunohost settings set email.relay.user -v "your-brevo-email@example.com"
   sudo yunohost settings set email.relay.password -v "your-smtp-key-here"
   sudo systemctl restart postfix
   ```

4. **Verify sender in Brevo:**
   - Go to: Settings → Senders & IPs → Senders
   - Add: `bonfire@your-domain.tld`
   - Click verify and confirm via email

5. **Test the configuration:**
   ```bash
   echo "Test" | mail -s "Test" -r "bonfire@your-domain.tld" your-email@example.com
   ```

#### Alternative: Configure Bonfire Directly

Edit `/var/www/bonfire/.env` to use external SMTP:

```bash
# For SMTP with authentication:
MAIL_BACKEND=smtp
MAIL_SERVER=smtp.example.com
MAIL_PORT=587
MAIL_USER=your-username
MAIL_PASSWORD=your-password
MAIL_DOMAIN=your-domain.tld
MAIL_FROM=noreply@your-domain.tld

# For API-based services (Mailgun, Sendgrid, etc):
MAIL_BACKEND=mailgun
MAIL_KEY=your-api-key
MAIL_DOMAIN=mg.your-domain.tld
MAIL_BASE_URI=https://api.eu.mailgun.net/v3
```

After editing, restart Bonfire:
```bash
sudo systemctl restart bonfire
```

### First Admin Account

The first user to sign up on your Bonfire instance automatically becomes an administrator. Visit your instance at `https://your-domain.tld/` and create your account.

**Note:** User signup requires working email for verification!

### Admin Panel

Once logged in as an admin, you can access the admin panel at:
- LiveDashboard for system metrics: `/admin/system/`

### Managing the Service

To restart Bonfire:
```bash
sudo systemctl restart bonfire
```

To check service status:
```bash
sudo systemctl status bonfire
```

### Logs

Bonfire logs are available at:
- Application logs: `/var/log/bonfire/bonfire.log`
- Meilisearch logs: `/var/log/bonfire/meilisearch.log`
- System logs: `sudo journalctl -u bonfire`

### Database Access

The PostgreSQL database can be accessed with:
```bash
sudo -u postgres psql bonfire
```

### File Locations

- Installation directory: `__INSTALL_DIR__`
- Data directory (uploads, search index): `__DATA_DIR__`
- Configuration: `__INSTALL_DIR__/.env`
