## Bonfire Administration

### First Admin Account

The first user to sign up on your Bonfire instance automatically becomes an administrator. Visit your instance at `https://your-domain.tld/` and create your account.

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
