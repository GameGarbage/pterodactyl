#!/bin/bash

# Update and install required packages
apt update -y && apt upgrade -y
apt install -y docker.io curl unzip

# Install Docker
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create a directory for Pterodactyl
mkdir -p /opt/pterodactyl
cd /opt/pterodactyl

# Create the .env file for Docker
echo "DOCKER_USERNAME=phatnguyentan0491" > ./.env
echo "DOCKER_PASSWORD=Loc2002_bl" >> ./.env

# Set proper permissions for the .env file
chmod 600 ./.env

# Write the Docker Compose file
cat > docker-compose.yml <<EOF
version: '3.8'

services:
  panel:
    image: ghcr.io/pterodactyl/panel:latest
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
    image: ghcr.io/pterodactyl/wings:latest
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
    image: mariadb:10.5
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

sudo usermod -aG docker $USER
newgrp docker

export $(cat .env | xargs)
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# Deploy the Docker Compose stack
docker-compose up -d
