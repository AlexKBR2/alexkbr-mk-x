#!/usr/bin/env bash
# Cria um usuario de teste (mkx) e garante que o sistema inicie no modo grafico.
# Senha provisoria: o sistema obriga a trocar no primeiro login.
# "set -x" mostra cada comando no log da build, para facilitar achar erros.
set -euxo pipefail

# Garante que os grupos existam
for g in wheel video audio; do
  getent group "$g" >/dev/null || groupadd -r "$g"
done

# Cria o usuario (sem fixar o UID) e define a senha provisoria
id mkx >/dev/null 2>&1 || useradd -d /var/home/mkx -M -s /bin/bash -G wheel,video,audio mkx
echo 'mkx:trocar123' | chpasswd
chage -d 0 mkx

# Cria a pasta pessoal no primeiro boot (em sistemas Atomic ela fica em /var)
mkdir -p /usr/lib/tmpfiles.d
printf 'd /var/home/mkx 0700 mkx mkx -\n' > /usr/lib/tmpfiles.d/mk-x-home.conf

# Inicia direto na interface grafica
mkdir -p /etc/systemd/system
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
