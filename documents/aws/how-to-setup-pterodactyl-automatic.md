To automate the setup of Pterodactyl with Docker Compose on AWS, you can use tools like **Terraform** for provisioning the AWS infrastructure and **CloudInit/User Data scripts** for configuring the instance automatically. Here's how you can fully automate the process:

---

### **1. Overview of Automation Steps**
1. **Use Terraform** to:
   - Launch an EC2 instance.
   - Set up the necessary security groups and storage.

2. **Provide a User Data script** for automatic instance configuration.

3. **Store the Docker Compose configuration** in a repository or include it directly in the User Data script.

---

### **2. Terraform for Infrastructure Provisioning**
Create a `main.tf` file for provisioning an EC2 instance and security groups.

#### Example `main.tf` File:
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "pterodactyl" {
  ami           = "ami-12345678" # Replace with the desired AMI (e.g., Ubuntu 20.04)
  instance_type = "t2.medium"
  key_name      = "your-key-name"
  security_groups = ["pterodactyl-sg"]

  # User Data script
  user_data = file("user-data.sh")

  tags = {
    Name = "Pterodactyl-Server"
  }
}

resource "aws_security_group" "pterodactyl-sg" {
  name        = "pterodactyl-sg"
  description = "Security group for Pterodactyl server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---

### **3. User Data Script for Automatic Configuration**
Create a `user-data.sh` script that will install Docker, Docker Compose, and configure Pterodactyl automatically.

#### Example `user-data.sh`:
```bash
#!/bin/bash

# Update and install required packages
apt update -y && apt upgrade -y
apt install -y docker.io curl unzip

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create a directory for Pterodactyl
mkdir -p /opt/pterodactyl
cd /opt/pterodactyl

# Write the Docker Compose file
cat > docker-compose.yml <<EOF
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
      - APP_URL=http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
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
      - PANEL_URL=http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
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
EOF

# Deploy the Docker Compose stack
docker-compose up -d
```

---

### **4. Automate with Terraform and the User Data Script**
Save the `user-data.sh` file alongside your Terraform script and reference it in the `main.tf` file:
```hcl
user_data = file("user-data.sh")
```

---

### **5. Run the Automation**
1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Plan the Infrastructure:**
   ```bash
   terraform plan
   ```

3. **Apply the Configuration:**
   ```bash
   terraform apply
   ```

---

### **6. Access the Pterodactyl Panel**
- Once the instance is running, access the panel using the instance's public IP:
  ```
  http://<instance-public-ip>
  ```

- The setup process (like database configuration) will be accessible via the browser.

---

### **7. Extend Automation (Optional)**
1. **Use SSL Automatically:**
   Include a script to configure Let's Encrypt certificates automatically.

2. **Automate Scaling:**
   Use Terraform to create an Auto Scaling group or Elastic Load Balancer for the EC2 instances.

3. **Centralized Secrets:**
   Store sensitive data (like database credentials) in AWS Secrets Manager or Parameter Store, and fetch them dynamically.

---

This setup ensures that Pterodactyl is deployed automatically using Terraform and Docker Compose, requiring minimal manual intervention. Let me know if you'd like assistance refining any of these steps!