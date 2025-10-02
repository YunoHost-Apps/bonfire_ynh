## 🎉 Bonfire Successfully Installed!

### ⚠️ Critical: Email Configuration Required

**Your Bonfire instance requires working email to function properly!** Email is essential for:
- User signup verification
- Password resets
- Notifications

#### Quick Email Setup Check:

1. **Test if email is working:**
   ```bash
   echo "Test" | mail -s "Test" -r "__ID__@__DOMAIN__" your-email@example.com
   sudo tail -f /var/log/mail.log
   ```

2. **If emails are NOT sending (common issue):**

   Most servers have port 25 blocked. You'll need to configure an SMTP relay:

   **Option A: Configure YunoHost Email Relay (Recommended)**
   1. Sign up for a free account at [Brevo.com](https://www.brevo.com) (300 emails/day free)
   2. Get your SMTP credentials from: SMTP & API → SMTP settings
   3. Configure YunoHost relay:
      - Go to: YunoHost Admin → Tools → Settings → Email
      - Enable SMTP relay
      - Enter:
        - Host: `smtp-relay.brevo.com`
        - Port: `587`
        - User: Your Brevo email
        - Password: Your SMTP key (NOT your login password!)
   4. **Important:** Add `__ID__@__DOMAIN__` as a verified sender in Brevo:
      - Go to Settings → Senders & IPs → Senders
      - Add and verify the email address
   5. Restart services: `sudo systemctl restart postfix`

   **Option B: Configure Bonfire directly (Advanced)**
   - Edit `/var/www/__ID__/.env` to add your SMTP credentials
   - See admin documentation for details

### ⚠️ Important: Create Your Admin Account

Visit your Bonfire instance at: <https://__DOMAIN____PATH__>

**The first user to sign up becomes the administrator!**

Please create your admin account immediately to secure your instance.

### Next Steps

1. Ensure email is working (test signup with your email)
2. Sign up with your desired username and email
3. Configure your instance settings in the admin panel
4. Invite other users if you've enabled invite-only mode
5. Connect with the fediverse!

### Need Help?

- Documentation: https://bonfirenetworks.org/docs/
- Admin panel: <https://__DOMAIN____PATH__admin/system/>
- Logs location: `/var/log/__ID__/`
- Email issues: Check `/var/log/mail.log`
