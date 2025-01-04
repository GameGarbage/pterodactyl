To set up Pterodactyl using Docker Compose on AWS, you need to deploy the Pterodactyl Panel and Wings services in Docker containers. This method simplifies installation, makes updates easier, and ensures portability.

Here’s a step-by-step guide:

---

### **1. Launch an EC2 Instance**
1. **Choose an Instance:**
   - Use Ubuntu 20.04/22.04 or Amazon Linux 2 as the AMI.
   - Select an instance type (t2.medium or larger for better performance).
   - Add at least **20 GB of storage**.

2. **Set Up Security Groups:**
   - Allow the following ports:
     - **80** (HTTP) and **443** (HTTPS) for web access.
     - **8080** (Wings daemon).
     - **22** (SSH) for remote access.

3. **SSH into the Instance:**
   ```bash
   ssh -i "your-key.pem" ubuntu@<instance-public-ip>
   ```

---

### **2. Install Docker and Docker Compose**
1. **Update the System:**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Install Docker:**
   ```bash
   sudo apt install -y docker.io
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

3. **Install Docker Compose:**
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

---

### **3. Set Up Docker Compose for Pterodactyl**
1. **Create a Directory for Pterodactyl:**
   ```bash
   mkdir -p ~/pterodactyl
   cd ~/pterodactyl
   ```

2. **Create a `docker-compose.yml` File:**
   ```bash
   nano docker-compose.yml
   ```

3. **Add the Following Configuration:**

   ```yaml
   version: '3.8'

   services:
     panel:
       image: pterodactyl/panel:latest
       container_name: pterodactyl_panel
       ports:
         - "80:80"
         - "443:443"
       volumes:
         - panel_data:/var/www/html
       environment:
         - APP_URL=http://<your-domain-or-ip>
         - DB_HOST=db
         - DB_PORT=3306
         - DB_DATABASE=pterodactyl
         - DB_USERNAME=pterodactyl
         - DB_PASSWORD=strongpassword
       depends_on:
         - db

     wings:
       image: pterodactyl/wings:latest
       container_name: pterodactyl_wings
       ports:
         - "8080:8080"
       volumes:
         - wings_data:/etc/pterodactyl
       environment:
         - NODE_HOST=0.0.0.0
         - PANEL_URL=http://<your-domain-or-ip>
         - WINGS_TOKEN=your-wings-token

     db:
       image: mariadb:10.6
       container_name: pterodactyl_db
       environment:
         - MYSQL_ROOT_PASSWORD=rootpassword
         - MYSQL_DATABASE=pterodactyl
         - MYSQL_USER=pterodactyl
         - MYSQL_PASSWORD=strongpassword
       volumes:
         - db_data:/var/lib/mysql

   volumes:
     panel_data:
     wings_data:
     db_data:
   ```

---

### **4. Deploy the Stack**
1. **Start Docker Compose:**
   ```bash
   docker-compose up -d
   ```

2. **Verify the Containers:**
   ```bash
   docker ps
   ```
   You should see three containers running: `pterodactyl_panel`, `pterodactyl_wings`, and `pterodactyl_db`.

---

### **5. Configure Pterodactyl Panel**
1. **Access the Panel:**
   - Open your browser and navigate to `http://<instance-public-ip>`.

2. **Follow the Setup Wizard:**
   - Configure the database using:
     - Host: `db`
     - Port: `3306`
     - Database: `pterodactyl`
     - Username: `pterodactyl`
     - Password: `strongpassword`

3. **Set the Admin Account:**
   - Complete the setup by creating an admin account.

---

### **6. Secure with SSL**
Use Let's Encrypt to secure the panel with HTTPS:

1. **Install Certbot:**
   ```bash
   sudo apt install certbot
   ```

2. **Run Certbot in the Panel Container:**
   ```bash
   docker exec -it pterodactyl_panel certbot --nginx
   ```

3. **Renew Certificates Automatically:**
   ```bash
   crontab -e
   ```
   Add the following line to renew SSL certificates automatically:
   ```
   0 0 * * * docker exec pterodactyl_panel certbot renew --quiet
   ```

---

### **7. Test and Maintain**
- Test the panel and daemon functionality.
- Use `docker-compose logs` to debug issues.
- Backup important data:
  ```bash
  docker-compose down
  tar -czvf backup.tar.gz ~/pterodactyl
  ```

---

This setup uses Docker Compose to simplify the management and deployment of Pterodactyl on AWS. Let me know if you encounter any issues or need further assistance!