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


# Abra o arquivo de configuração no servidor do bacula.
# vim /etc/bacula/bacula-dir.conf

# No bacula-dir.conf, insira o seguinte:

# Definindo as configurações do Storage no servidor Bacula.
# Storage {  
#   Name = "baculasd"  # Nome do Storage (Deve ser o mesmo nome no arquivo bacula-sd.conf no storage).
#   SdPort = 9103  # Porta padrão de comunicação do bacula com o storage.
#   Address = "0.0.0.0"  # IP do Storage.
#   Password = "BACULA-SD-PASSWORD"  # Senha que o Usuário bacula usa para acessar o storage.
#   Device = "VirtualAutochanger-exemplo"  # Nome do Autochanger (Deve ser o mesmo nome no arquivo bacula-sd.conf no storage).
#   MediaType = "File1"  # Tipo de mídia (Deve ser o mesmo nome no arquivo bacula-sd.conf no storage).
#   Autochanger = "yes"  # Permite o autochanger.
#   MaximumConcurrentJobs = 10  # Libera Jobs simultâneos.
# }

# Configuração do Bacula-Sd
# Abra o arquivo de configuração no servidor do Storage.
# vim /etc/bacula/bacula-sd.conf

# No bacula-sd.conf, insira o seguinte:

# Definindo as configurações do Autochanger.
# Autochanger {  
#   Name = "VirtualAutochanger-exemplo"  # Nome do Autochanger (Deve ser o mesmo nome no arquivo bacula-dir.conf no servidor do bacula).
#   Changer Command= "/dev/null"  # Comando Trocador (Para backups em disco, o comando deve ser "/dev/null").
#   Changer Device= "/dev/null"  # Dispositivo Trocador (Para backups em disco, o dispositivo deve ser "/dev/null").
#   Device = FileChgr1-Dev1, FileChgr1-Dev2, ...  # Devices que esse autochanger pode usar.
# }

# Definição dos Devices que podem ser usados por autochangers.
# Device {  
#   Name = FileChgr1-Dev1  # Nome do Device.
#   Device Type = File  # Tipo de device.
#   Media Type = File1  # Tipo de mídia (Deve ser o mesmo nome no arquivo bacula-dir.conf no servidor do bacula).
#   Archive Device = /backup/bacula  # Local onde os arquivos do backup serão salvos. (Pode ser o mesmo em todos os devices).
#   LabelMedia = yes  # Permite que o bacula rotule mídias não rotuladas.
#   Random Access = yes  # Permite que o bacula acesse volumes de forma aleatória.
#   AutomaticMount = yes  # Permite que o bacula monte volumes automaticamente.
#   RemovableMedia = yes  # Permite que o bacula remova mídias.
#   AlwaysOpen = yes  # Sempre aberto.
#   Autochanger = yes  # Permite o Autochanger.
#   Drive Index = 0  # Index do device (Deve ser diferente em cada Device).
#   Maximum Concurrent Jobs = 10  # Permite Jobs simultâneos.
# }

# Definição do segundo Device que pode ser usado pelos autochangers.
# Device {  
#   Name = FileChgr1-Dev2  # Nome do segundo Device.
#   ...  # Outras configurações podem ser adicionadas aqui.
#   ...  # Continuação de outras configurações de dispositivos.
#   ...  # Continuação do arquivo de configuração.
# }
