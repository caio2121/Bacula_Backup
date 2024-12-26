# Bacula e Backup Scripts

Este repositório contém scripts e configurações para automação, gerenciamento e monitoramento de backups utilizando o **Bacula**. O objetivo é fornecer uma solução prática para configurar, agendar e verificar backups de maneira eficiente, garantindo a integridade e a segurança dos dados.

## 🚀 Funcionalidades

- **Configuração do Bacula**: Scripts para configurar o Bacula Director otimizando a implementação do sistema de backup.
- **Automação de Backup**: Agendamento automatizado de backups completos, incrementais e diferenciais para garantir a eficiência do processo de backup.
- **Monitoramento de Backup**: Ferramentas para monitorar a execução dos backups e gerar alertas em caso de falhas ou problemas de execução.
- **Relatórios Detalhados**: Geração de relatórios sobre o status dos backups, incluindo informações sobre sucesso, falha e dados transferidos.

## 🛠 Tecnologias Usadas

- **Bacula**: Sistema de backup de código aberto, amplamente utilizado e confiável para o gerenciamento de dados.
- **Shell Scripts**: Utilização de scripts em Bash para automação das tarefas de backup.


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
   chmod +x install_bacula.sh
   ```

8. Execute o script de instalação para configurar o Bacula:
   ```bash
   ./install_bacula.sh
   ```

9. Após a instalação, configure corretamente as senhas utilizadas no código para garantir a segurança e o funcionamento adequado do sistema.

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

