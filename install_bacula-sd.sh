#!/bin/bash

# Atualizar repositórios e instalar dependências necessárias
echo "Atualizando repositórios e instalando dependências..."
sudo apt update && sudo apt install -y \
    build-essential \
    libpq-dev \
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

# Configurar, compilar e instalar o Bacula SD
echo "Configurando o Bacula Storage Daemon (SD)..."
./configure \
    --with-readline=/usr/include/readline \
    --disable-conio \
    --bindir=/usr/bin \
    --sbindir=/usr/sbin \
    --with-scriptdir=/etc/bacula/scripts \
    --with-working-dir=/var/lib/bacula \
    --with-logdir=/var/log \
    --enable-smartalloc \
    --with-postgresql \
    --with-archivedir=/backup/bacula \
    --enable-build-dird=no

make -j$(nproc)
echo "Instalando o Bacula Storage Daemon (SD)..."
make install
make install-autostart

# Desabilitar Bacula File Daemon e Director Daemon
echo "Desabilitando os serviços Bacula File Daemon e Bacula Director Daemon..."
systemctl disable bacula-fd bacula-dir

# Habilitar e iniciar o Bacula Storage Daemon
echo "Habilitando e iniciando o Bacula Storage Daemon..."
systemctl enable bacula-sd
systemctl start bacula-sd

# Copiar arquivos de configuração personalizados para o diretório correto
echo "Copiando arquivos de configuração para o diretório do Bacula..."
mv "$config_repo_dir/bacula-sd.modelo.conf" /etc/bacula/bacula-sd.conf

echo "Instalação e configuração do Bacula Storage Daemon concluídas."
