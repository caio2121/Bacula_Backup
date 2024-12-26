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
sudo useradd -m -s /bin/bash bacula

# Configuração do PostgreSQL
echo "Configurando o PostgreSQL para o Bacula Director..."
# Dar permissões ao usuário postgres
sudo gpasswd -a postgres root
sudo gpasswd -a bacula root

#echo "Movendo os arquivos de configuração para os locais corretos..."
sudo mv /usr/src/backup/Bacula-Backup/bconsole.modelo.conf /etc/bacula/bconsole.conf
sudo mv /usr/src/backup/Bacula-Backup/bacula-dir.modelo.conf /etc/bacula/bacula-dir.conf

echo "Garantindo permissões nos diretórios e arquivos do Bacula..."
sudo chown -R bacula:bacula /etc/bacula /var/lib/bacula /var/log/bacula

# Executar os scripts de criação do banco de dados Bacula
echo "Executando os scripts para configurar o banco de dados PostgreSQL..."
sudo -u postgres bash -c "
psql <<EOF
CREATE USER bacula WITH PASSWORD 'mudar123';
ALTER ROLE bacula WITH SUPERUSER;
EOF
"

# Substituindo 'peer' por 'md5' no arquivo pg_hba.conf
echo "Substituindo 'peer' por 'md5' no arquivo /etc/postgresql/13/main/pg_hba.conf..."
sudo sed -i 's/peer/md5/g' /etc/postgresql/13/main/pg_hba.conf

# Reiniciar o PostgreSQL
echo "Reiniciando o PostgreSQL..."
sudo systemctl restart postgresql


sudo -u bacula bash -c "/etc/bacula/scripts/create_postgresql_database"
sudo -u bacula bash -c "/etc/bacula/scripts/make_postgresql_tables"
sudo -u bacula bash -c "/etc/bacula/scripts/grant_postgresql_privileges"

# Iniciar e habilitar o Bacula Director
echo "Habilitando e iniciando o Bacula Director..."
sudo systemctl enable bacula-dir
sudo systemctl restart bacula-dir

# Instalação e configuração do Bacula Director concluídas."
