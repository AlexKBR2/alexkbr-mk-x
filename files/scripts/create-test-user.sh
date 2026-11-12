#!/usr/bin/env bash
# Cria um usuario de teste (mkx) e garante que o sistema inicie no modo grafico.
# Senha de teste: trocar123 (troque depois, e remova este usuario antes de distribuir).
# "set -x" mostra cada comando no log da build, para facilitar achar erros.
set -euxo pipefail

# Cria o usuario com acesso ao sudo (grupo wheel) e define a senha de teste.
# Acesso a audio e video e liberado pelo proprio sistema, sem precisar de grupos.
id mkx >/dev/null 2>&1 || useradd -d /var/home/mkx -M -s /bin/bash -G wheel mkx
echo 'mkx:trocar123' | chpasswd

# Cria a pasta pessoal no primeiro boot (em sistemas Atomic ela fica em /var)
mkdir -p /usr/lib/tmpfiles.d
printf 'd /var/home/mkx 0700 mkx mkx -\n' > /usr/lib/tmpfiles.d/mk-x-home.conf

# Inicia direto na interface grafica
mkdir -p /etc/systemd/system
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target

# Pastas que o lightdm precisa em /var (em sistemas Atomic elas nao vem prontas)
cat > /usr/lib/tmpfiles.d/mk-x-lightdm.conf <<'TMP'
d /var/lib/lightdm 0755 lightdm lightdm -
d /var/lib/lightdm-data 0755 lightdm lightdm -
d /var/cache/lightdm 0755 lightdm lightdm -
TMP
