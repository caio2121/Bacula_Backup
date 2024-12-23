#!/bin/bash

# Atualizar repositórios e instalar dependências necessárias
echo "Atualizando repositórios e instalando dependências..."
sudo apt update && sudo apt install -y \
    build-essential \
    zlib1g-dev \
    pbzip2 \
    libpq-dev \
    postgresql \
    postgresql-client \
    wget \
    tar

# Variáveis
download_url="https://www.bacula.org/download/11487/?tmstv=1731045036"
version="15.0.2"
source_dir="/usr/src"
bacula_tar="bacula-${version}.tar.gz"
bacula_dir="bacula-${version}"

# Baixar e renomear o arquivo do Bacula
echo "Baixando o Bacula versão $version..."
cd "$source_dir" || exit 1
wget "$download_url" -O bacula-download.tmp
mv bacula-download.tmp "$bacula_tar"

# Descompactar o Bacula
echo "Descompactando o Bacula..."
tar -zxvf "$bacula_tar"
cd "$bacula_dir" || exit 1

# Configurar, compilar e instalar o Bacula Director
echo "Configurando o Bacula Director com suporte ao PostgreSQL..."
./configure \
    --with-postgresql \
    --with-readline=/usr/include/readline \
    --disable-conio \
    --bindir=/usr/bin \
    --sbindir=/usr/sbin \
    --with-scriptdir=/etc/bacula/scripts \
    --with-working-dir=/var/lib/bacula \
    --with-logdir=/var/log \
    --with-plugindir=/usr/lib/bacula \
    --enable-smartalloc \
    --enable-build-fd=no \
    --enable-build-stored=no

make -j$(nproc)
echo "Instalando o Bacula Director..."
make install
make install-autostart

# Criar o usuário Bacula e definir permissões
echo "Criando o usuário bacula e configurando permissões..."
sudo useradd -r -s /bin/false bacula
sudo chown -R bacula:bacula /var/lib/bacula

# Configuração do PostgreSQL
echo "Configurando o PostgreSQL para o Bacula Director..."
# Dar permissões ao usuário postgres
sudo chmod 700 /var/lib/postgresql
sudo chown postgres:postgres /var/lib/postgresql

# Executar os scripts de criação do banco de dados Bacula
echo "Executando os scripts para configurar o banco de dados PostgreSQL..."
gpasswd -a postgres root
sudo -u postgres bash -c "/etc/bacula/scripts/create_postgresql_database"
sudo -u postgres bash -c "/etc/bacula/scripts/make_postgresql_tables"
sudo -u postgres bash -c "/etc/bacula/scripts/grant_postgresql_privileges"

# Iniciar e habilitar o Bacula Director
echo "Habilitando e iniciando o Bacula Director..."
sudo systemctl enable bacula-dir
sudo systemctl start bacula-dir

# Configuração do Bacula Director
echo "Editando o arquivo de configuração do Bacula Director..."
sudo vim /etc/bacula/bacula-dir.conf

echo "Instalação e configuração do Bacula Director concluídas."
