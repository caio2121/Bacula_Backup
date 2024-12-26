# Bacula e Backup Scripts

Este repositório contém scripts e configurações para automação, gerenciamento e monitoramento de backups utilizando o **Bacula**. O script principal automatiza a instalação e configuração do Bacula Director com suporte ao **PostgreSQL**, incluindo ajustes em permissões, criação de usuários e configuração do banco de dados.

## 🚀 Funcionalidades

- **Configuração do Bacula Director**: Instalação e configuração automática do Bacula Director com suporte ao PostgreSQL.
- **Criação de Usuários e Banco de Dados**: Configuração automatizada do PostgreSQL, criação de usuários, banco de dados e permissões necessárias para o funcionamento do Bacula.
- **Ajustes de Permissões**: Configuração de permissões para diretórios e arquivos relacionados ao Bacula, garantindo o funcionamento seguro.
- **Automação de Backup**: Scripts para agendar backups e otimizar processos de gestão de dados.
- **Monitoramento e Relatórios**: Ferramentas para verificar a execução dos backups e gerar relatórios detalhados sobre o status das operações.

## 🛠 Tecnologias Usadas

- **Bacula**: Sistema de backup de código aberto, amplamente utilizado e confiável para o gerenciamento de dados.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar as informações do Bacula.
- **Shell Scripts**: Utilização de scripts em Bash para automação das tarefas de instalação e configuração.

## 📖 Passo a Passo para Utilização

Siga os passos abaixo para preparar o ambiente e utilizar os scripts:

1. Atualize a lista de pacotes:
   ```bash
   apt update
   ```

2. Instale o Git:
   ```bash
   apt install git -y
   ```

3. Crie o diretório para os scripts de backup:
   ```bash
   mkdir -p /usr/src/backup
   ```

4. Acesse o diretório criado:
   ```bash
   cd /usr/src/backup
   ```

5. Clone o repositório:
   ```bash
   git clone https://github.com/caio2121/Bacula_Backup.git
   ```

6. Acesse o diretório do repositório clonado:
   ```bash
   cd Bacula_Backup
   ```

7. Torne o script de instalação executável:
   ```bash
   chmod +x install_bacula.sh && chmod +x install_baculum.sh
   ```

8. Personalize as configurações: **Antes de executar o script**, edite os arquivos .modelo para ajustar as senhas e variáveis sensíveis conforme suas necessidades.

9. Execute o script de instalação para configurar o Bacula:
   ```bash
   ./install_bacula.sh %% ./install_baculum.sh
   ```

10. Após a instalação, verifique se os serviços estão funcionando corretamente e ajuste as configurações, se necessário. (senha do baculum: admin)

### ⚙️ Requisitos e Compatibilidade

- O script foi testado no **Debian 12**.
- Utiliza a versão **15.0.2** do Bacula.

## 🤝 Contribuições

Sinta-se à vontade para contribuir com melhorias, correções ou novas funcionalidades. Para isso, basta fazer um fork do repositório e enviar um pull request.

## 📞 Contato

Em caso de dúvidas, sinta-se à vontade para abrir uma **issue** ou entrar em contato diretamente.

caioalberto.abreu@gmail.com

---

🔧 **Desenvolvido por Caio Abreu**

