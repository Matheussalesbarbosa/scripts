### apt
* ``apt autoremove`` remover pacotes não utilizados
* ``apt check`` checar se não há dependências quebradas
* ``apt clean`` apagar download de pacotes
* ``apt install`` instalar pacote
* ``apt install -f`` instalar dependências de pacote
* ``apt install exfat-fuse exfat-utils`` instalar pacote exfat
* ``apt update`` atualizar pacotes
* ``apt upgrade`` atualizar sistema
---

### cat
* ``cat`` concaternar arquivos/visualizar conteúdo de arquivo
---

### cd
* ``cd`` mudar diretório
* ``cd /`` mudar para diretório root
* ``cd ~`` mudar para diretório home do usuário
* ``cd ..`` voltar um nível de diretório
* ``cd ../..`` voltar dois níveis de diretório
---

### chown
* ``chown user_name`` mudar propriedade de arquivo/diretório
---

### chmod
* ``chmod 777`` dar permissão total para arquivo/diretório
---

### cp
* ``cp`` copiar arquivo/diretório
---

### df
* ``df -h`` uso no disco
---

### dpkg
* ``dpkg -i`` instalar .deb
---

### du
* ``for dirs in $(ls --color=never -l | grep "^d" | awk '{print $9}'); do du -hs $dirs;done`` visualizar tamanho de diretórios
---

### grep
* ``fgrep -o | wc -l`` contar caractere no arquivo
---

### history
* ``history`` visualizar histórico de comandos
---

### htop
* ``htop`` gerenciador de tarefas
---

### ls
*``l`` listar conteúdo de diretório
*``la`` lista conteúdo de diretório com arquivos/diretórios ocultos
*``ll`` listar conteúdo de diretório com informação de permissão de arquivos/diretórios 
* ``ls`` listar conteúdo de diretório
---

### mkdir
* ``mkdir`` criar diretório
---

### mv
* ``mv`` mover/renomear arquivo/diretório
---

### nano
* ``nano`` editor de texto
---

### nohup
* ``nohup`` rodar parâmetro em segundo plano
---

### rm
* ``rm -r`` remover arquivo/diretório
---

### sed
* ``sed -i -e 's/\r$//'`` editar texto para retirar espaços não lidos no linux
---

### sh
* ``sh`` executar .sh
---

### ssh
* ``ssh -x`` acesso servidor remoto
---

### sudo
* ``sudo`` permissão root
* ``sudo -s`` usuário root
---

### tar
* ``tar -czvf`` compactar .tar.gz
* ``tar -vzxf`` descompactar .tar.gz
---

### wget
* ``wget`` baixar pacote
---

### zip
* ``zip -9 -r`` compactar .zip
* ``unzip`` descompactar .zip
---

- UPDATE BASH
```sh
curl http://data.biostarhandbook.com/install/bash_profile.txt >> ~/.bash_profile
curl http://data.biostarhandbook.com/install/bashrc.txt >> ~/.bashrc
source	~/.bash_profile
```
---
