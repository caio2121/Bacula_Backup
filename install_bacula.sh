#!/bin/bash

# Atualizando pacotes e instalando dependências essenciais
apt update && apt upgrade -y
apt install build-essential zlib1g-dev pbzip2 wget libreadline-dev -y

# Instalando o PostgreSQL e as dependências do PostgreSQL para Bacula
apt install postgresql postgresql-contrib libpq-dev -y

# Baixando o código-fonte do Bacula 15.0.2
cd /usr/src/
wget https://ufpr.dl.sourceforge.net/project/bacula/bacula/15.0.2/bacula-15.0.2.tar.gz
tar -zxvf bacula-15.0.2.tar.gz
cd bacula-15.0.2

# Configurando o Bacula com suporte ao PostgreSQL
./configure --with-readline=/usr/include/readline --disable-conio --bindir=/usr/bin --sbindir=/usr/sbin \
            --with-scriptdir=/etc/bacula/scripts --with-working-dir=/var/lib/bacula --with-logdir=/var/log \
            --enable-smartalloc --enable-client-only=no --enable-build-dird=yes --enable-build-stored=no \
            --with-pgsql=/usr/include/pgsql --enable-pgsql

# Compilando e instalando o Bacula Director
make -j$(nproc)
make install
make install-autostart

# Desabilitando Bacula SD e Bacula FD, habilitando Bacula Director
systemctl disable bacula-sd bacula-fd
systemctl enable bacula-dir

# Configuração do PostgreSQL
# Criando banco de dados e usuário no PostgreSQL
echo "Criando usuário e banco de dados para Bacula no PostgreSQL..."
sudo -u postgres psql -c "CREATE USER bacula WITH PASSWORD 'senha_bacula';"
sudo -u postgres psql -c "CREATE DATABASE bacula ENCODING='UTF8' OWNER bacula;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE bacula TO bacula;"

# Configuração do Bacula Director
echo "Por favor, edite o arquivo de configuração do Bacula Director (/etc/bacula/bacula-dir.conf) conforme necessário."
vim /etc/bacula/bacula-dir.conf

# Iniciando o Bacula Director
echo "Iniciando o Bacula Director..."
systemctl start bacula-dir

# Finalizando a instalação
echo "Instalação concluída! O Bacula Director está configurado e em execução."
