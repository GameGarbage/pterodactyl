

Setting up Pterodactyl on AWS involves multiple steps, including configuring an EC2 instance, setting up a database, installing dependencies, and configuring the Pterodactyl panel and daemon. Here's a detailed guide:

---

### **Step 1: Launch an AWS EC2 Instance**
1. **Login to AWS Console:**
   - Navigate to the EC2 service.
2. **Launch an Instance:**
   - Choose an Amazon Linux 2, Ubuntu, or Debian AMI.
   - Select an instance type (t2.medium or larger is recommended for better performance).
   - Configure the instance with at least **20 GB of storage** and a security group allowing HTTP (80), HTTPS (443), and custom ports (e.g., 8080 for Pterodactyl).
3. **Assign Elastic IP (Optional):**
   - Allocate and associate an Elastic IP for consistent public access.
4. **Access the Instance:**
   - SSH into the instance using your private key.

---

### **Step 2: Install Dependencies**
Run these commands on the instance:

#### 1. **Update the System**
```bash
sudo apt update && sudo apt upgrade -y
```
(For Amazon Linux: `sudo yum update -y`)

#### 2. **Install Required Software**
```bash
sudo apt install -y nginx mariadb-server software-properties-common curl unzip tar
```

#### 3. **Install PHP**
Add the repository and install PHP 8.1 or higher:
```bash
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php8.1 php8.1-cli php8.1-curl php8.1-mbstring php8.1-xml php8.1-mysql php8.1-zip php8.1-gd
```

#### 4. **Install Composer**
```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

#### 5. **Install Node.js and Yarn**
```bash
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn
```

---

### **Step 3: Set Up the Database**
1. **Start MariaDB Service**
   ```bash
   sudo systemctl start mariadb
   sudo systemctl enable mariadb
   ```

2. **Secure MariaDB**
   ```bash
   sudo mysql_secure_installation
   ```

3. **Create a Database**
   ```sql
   CREATE DATABASE pterodactyl;
   CREATE USER 'pterodactyl'@'localhost' IDENTIFIED BY 'strongpassword';
   GRANT ALL PRIVILEGES ON pterodactyl.* TO 'pterodactyl'@'localhost';
   FLUSH PRIVILEGES;
   ```

---

### **Step 4: Install Pterodactyl Panel**
1. **Download the Panel**
   ```bash
   cd /var/www
   sudo mkdir pterodactyl
   cd pterodactyl
   curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
   sudo tar -xzvf panel.tar.gz
   sudo chmod -R 755 storage/* bootstrap/cache/
   ```

2. **Install Composer Dependencies**
   ```bash
   composer install --no-dev --optimize-autoloader
   ```

3. **Set Permissions**
   ```bash
   sudo chown -R www-data:www-data /var/www/pterodactyl
   ```

4. **Set Up the Environment**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

5. **Configure Database in `.env` File**

6. **Run Migrations**
   ```bash
   php artisan migrate --seed
   ```

7. **Set Up Queue Workers**
   ```bash
   sudo cp ./example.supervisord.conf /etc/supervisor/conf.d/pterodactyl-worker.conf
   sudo supervisorctl reread
   sudo supervisorctl update
   sudo supervisorctl start pterodactyl-worker:*
   ```

8. **Configure Nginx**
   - Create an Nginx site configuration:
     ```bash
     sudo nano /etc/nginx/sites-available/pterodactyl
     ```
   - Add the Nginx configuration from the [Pterodactyl documentation](https://pterodactyl.io/panel/1.0/webserver_configuration.html#nginx).

   - Enable the site:
     ```bash
     sudo ln -s /etc/nginx/sites-available/pterodactyl /etc/nginx/sites-enabled/
     sudo systemctl restart nginx
     ```

---

### **Step 5: Install Wings (Daemon)**
1. **Download and Install Wings**
   ```bash
   curl -Lo wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64
   chmod +x wings
   sudo mv wings /usr/local/bin
   ```

2. **Create a Systemd Service**
   ```bash
   sudo nano /etc/systemd/system/wings.service
   ```
   Add the service configuration:
   ```ini
   [Unit]
   Description=Pterodactyl Wings Daemon
   After=network.target

   [Service]
   User=root
   WorkingDirectory=/etc/pterodactyl
   ExecStart=/usr/local/bin/wings
   Restart=always
   LimitNOFILE=4096

   [Install]
   WantedBy=multi-user.target
   ```

3. **Start Wings**
   ```bash
   sudo systemctl enable wings
   sudo systemctl start wings
   ```

---

### **Step 6: Access the Panel**
1. Visit the EC2 public IP or domain in your browser.
2. Complete the setup wizard.

---

### **Step 7: Optional Enhancements**
- **Enable SSL:** Use Certbot to install a Let's Encrypt SSL certificate:
  ```bash
  sudo apt install certbot python3-certbot-nginx
  sudo certbot --nginx
  ```

- **Configure a Domain Name:** Point your domain to the Elastic IP.

--- 

Let me know if you encounter any issues!