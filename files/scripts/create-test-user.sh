#!/usr/bin/env bash
# Cria um usuario de teste (mkx) e garante que o sistema inicie no modo grafico.
# Senha provisoria: o sistema obriga a trocar no primeiro login.
set -euo pipefail

useradd -u 1000 -d /var/home/mkx -M -s /bin/bash -G wheel,video,audio mkx
echo 'mkx:trocar123' | chpasswd
chage -d 0 mkx

# Cria a pasta pessoal no primeiro boot (em sistemas Atomic ela fica em /var)
printf 'd /var/home/mkx 0700 mkx mkx -\n' > /usr/lib/tmpfiles.d/mk-x-home.conf

# Inicia direto na interface grafica
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
