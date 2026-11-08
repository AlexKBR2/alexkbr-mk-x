#!/usr/bin/env bash
# Instala tema GTK e icones inspirados no XP (arte da comunidade).
# ATENCAO: confirme URLs e licencas antes de distribuir. Nao inclua
# arquivos originais da Microsoft (Bliss, sons, logos): sao protegidos.
set -euo pipefail

THEME_REPO="https://github.com/B00merang-Project/Windows-XP"   # VERIFICAR
TMP="$(mktemp -d)"

git clone --depth 1 "$THEME_REPO" "$TMP/theme" || {
  echo "Nao foi possivel baixar o tema XP; seguindo com o tema padrao." >&2
  exit 0
}
mkdir -p /usr/share/themes/MK-X-Luna
cp -r "$TMP/theme/." /usr/share/themes/MK-X-Luna/
rm -rf /usr/share/themes/MK-X-Luna/.git "$TMP"
