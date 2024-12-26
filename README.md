# Bacula e Backup Scripts

Este repositório contém scripts de automação para instalação e configuração do **Bacula** e **Baculum**. O script principal automatiza a instalação do **Bacula 15.0.2** e do **Baculum**, configurando o Bacula Director com suporte ao PostgreSQL, além de realizar ajustes de permissões, criação de usuários e configuração do banco de dados.

## 🚀 Funcionalidades

- **Configuração do Bacula Director**: Instalação e configuração automática do Bacula Director com suporte ao PostgreSQL.
- **Configuração do Baculum**: Instalação do Baculum, configurando a interface web e a API para gerenciamento do Bacula.
- **Criação de Usuários e Banco de Dados**: Configuração automatizada do PostgreSQL, criação de usuários, banco de dados e permissões necessárias para o funcionamento do Bacula.
- **Ajustes de Permissões**: Configuração de permissões para diretórios e arquivos relacionados ao Bacula, garantindo o funcionamento seguro.
- **Automação de Backup**: Scripts para agendar backups e otimizar processos de gestão de dados.
- **Monitoramento e Relatórios**: Ferramentas para verificar a execução dos backups e gerar relatórios detalhados sobre o status das operações.

## 🛠 Tecnologias Usadas

- **Bacula**: Sistema de backup de código aberto, amplamente utilizado e confiável para o gerenciamento de dados.
- **Baculum**: Interface web para o Bacula, fornecendo uma maneira fácil de gerenciar e monitorar backups.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar as informações do Bacula.
- **Apache2 e PHP**: Usados para rodar a interface web do Baculum.
- **Shell Scripts**: Utilização de scripts em Bash para automação das tarefas de instalação e configuração.

## 📖 Passo a Passo para Utilização

Siga os passos abaixo para preparar o ambiente e utilizar os scripts:

1. **Atualize a lista de pacotes:**
   ```bash
   apt update
   ```

2. **Instale o Git:**
   ```bash
   apt install git -y
   ```

3. **Crie o diretório para os scripts de backup:**
   ```bash
   mkdir -p /usr/src/backup
   ```

4. **Acesse o diretório criado:**
   ```bash
   cd /usr/src/backup
   ```

5. **Clone o repositório:**
   ```bash
   git clone https://github.com/caio2121/Bacula_Backup.git
   ```

6. **Acesse o diretório do repositório clonado:**
   ```bash
   cd Bacula_Backup
   ```

7. **Torne os scripts executáveis:**
   ```bash
   chmod +x install_bacula.sh && chmod +x install_baculum.sh
   ```

8. **Personalize as configurações**: 
   **Antes de executar os scripts**, edite os arquivos `.modelo` para ajustar as senhas e variáveis sensíveis conforme suas necessidades.

9. **Execute os scripts de instalação para configurar o Bacula e o Baculum:**
   ```bash
   ./install_bacula.sh
   ./install_baculum.sh
   ```

10. **Após a instalação, verifique se os serviços estão funcionando corretamente** e ajuste as configurações, se necessário. (Senha do Baculum: `admin`)

### ⚙️ Requisitos e Compatibilidade

- O script foi testado no **Debian 11**.
- Utiliza a versão **15.0.2** do Bacula e **11** do Baculum.

## 🤝 Contribuições

Sinta-se à vontade para contribuir com melhorias, correções ou novas funcionalidades. Para isso, basta fazer um fork do repositório e enviar um pull request.

## 📞 Contato

Em caso de dúvidas, sinta-se à vontade para abrir uma **issue** ou entrar em contato diretamente.

caioalberto.abreu@gmail.com

---

🔧 **Desenvolvido por Caio Abreu**

---

