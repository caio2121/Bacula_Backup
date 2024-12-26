#!/bin/bash

# Atualizar repositórios e instalar dependências necessárias
echo "Atualizando repositórios e instalando dependências..."
sudo apt update && sudo apt install -y \
    build-essential \
    zlib1g-dev \
    pbzip2 \
    wget \
    tar

# Variáveis
version="15.0.2"
source_dir="/usr/src"
bacula_tar="bacula-${version}.tar.gz"
bacula_dir="bacula-${version}"
config_repo_dir="/usr/src/backup/Bacula_Backup"  # Substitua pelo caminho correto onde os arquivos de configuração estão

# Baixar e renomear o arquivo do Bacula
echo "Baixando o Bacula versão $version..."
cd "$source_dir" || exit 1
wget "https://www.bacula.org/download/11487/?tmstv=1731045036" -O bacula-download.tmp
mv bacula-download.tmp "$bacula_tar"

# Descompactar o Bacula
echo "Descompactando o Bacula..."
tar -zxvf "$bacula_tar"
cd "$bacula_dir" || exit 1

# Configurar, compilar e instalar o Bacula FD
echo "Configurando o Bacula File Daemon (FD)..."
./configure \
    --with-readline=/usr/include/readline \
    --disable-conio \
    --bindir=/usr/bin \
    --sbindir=/usr/sbin \
    --with-scriptdir=/etc/bacula/scripts \
    --with-working-dir=/var/lib/bacula \
    --with-logdir=/var/log \
    --enable-smartalloc \
    --enable-client-only \
    --enable-build-dird=no \
    --enable-build-stored=no

make -j$(nproc)
echo "Instalando o Bacula File Daemon (FD)..."
make install
make install-autostart

# Desabilitar Bacula Director e Storage Daemon
echo "Desabilitando os serviços Bacula Director e Storage Daemon..."
systemctl disable bacula-dir bacula-sd

# Habilitar e iniciar o Bacula File Daemon
echo "Habilitando e iniciando o Bacula File Daemon..."
systemctl enable bacula-fd
systemctl start bacula-fd

# Copiar arquivos de configuração personalizados para o diretório correto
echo "Copiando arquivos de configuração para o diretório do Bacula..."
mv "$config_repo_dir/bacula-fd.modelo.conf" /etc/bacula/bacula-fd.conf

echo "Instalação e configuração do Bacula File Daemon concluídas."
