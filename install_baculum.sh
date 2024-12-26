#!/bin/bash

# Passo 1: Adicionar a Chave Pública do Repositório
echo "Adicionando a chave pública do Baculum..."
wget -qO - https://www.bacula.org/downloads/baculum/baculum.pub | sudo apt-key add -

# Passo 2: Configurar o Repositório
echo "Configurando o repositório do Baculum..."
echo "deb https://www.bacula.org/downloads/baculum/stable-11/debian bullseye main" | sudo tee /etc/apt/sources.list.d/baculum.list
echo "deb-src https://www.bacula.org/downloads/baculum/stable-11/debian bullseye main" | sudo tee -a /etc/apt/sources.list.d/baculum.list

# Passo 3: Atualizar e Instalar o Baculum
echo "Atualizando o índice de pacotes..."
sudo apt update

# Instalar dependências do PHP
echo "Instalando dependências do PHP..."
sudo apt install -y apache2 php libapache2-mod-php php-cli php-mbstring php-intl php-xml php-curl php-zip php-bcmath

# Instalar ferramentas adicionais
echo "Instalando ferramentas adicionais..."
sudo apt install -y git unzip curl

# Instalar o Baculum
echo "Instalando o Baculum..."
sudo apt install -y baculum-web-apache2 baculum-api-apache2
sudo apt install -y baculum-common

# Copiar arquivos de configuração
echo "Copiando arquivos de configuração do Baculum..."
sudo cp -r /etc/baculum/* /var/www/html/

# Habilitar módulos do Apache
echo "Habilitando módulos e sites do Apache..."
sudo a2enmod rewrite
sudo a2ensite baculum.conf
sudo a2ensite baculum-web.conf
sudo a2ensite baculum-api.conf

# Ajustar permissões
echo "Ajustando permissões..."
sudo chown -R www-data:www-data /var/www/html/

# Reiniciar o Apache
echo "Reiniciando o Apache..."
sudo systemctl restart apache2

echo "Instalação do Baculum concluída!"
