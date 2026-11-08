# AlexKBR MK-X

Sistema operacional leve focado em jogos: Fedora Atomic (imagem BlueBuild) + XFCE com visual inspirado no XP, otimizado para PCs com GPU AMD.

## Como usar
1. Crie um repositorio no GitHub com estes arquivos.
2. Em Settings > Actions > General, marque *Read and write permissions*. (Esta versao nao usa assinatura de imagem.)
3. Faca push: o GitHub Actions gera a imagem em `ghcr.io/<usuario>/alexkbr-mk-x`.
4. Instale um Fedora Atomic qualquer e faca o rebase:
   `rpm-ostree rebase ostree-unverified-registry:ghcr.io/<usuario>/alexkbr-mk-x:latest`
5. Reinicie. Para voltar, `rpm-ostree rollback`.

## Gerar a ISO instalavel
Depois que a imagem estiver publicada (passo 3) e o pacote estiver publico (GitHub > seu perfil > Packages > alexkbr-mk-x > Package settings > Change visibility), va em **Actions > build-iso > Run workflow**,
informe a versao do Fedora e baixe o artefato `alexkbr-mk-x-iso` ao final (alguns GB).
Grave em pendrive com Ventoy ou Fedora Media Writer.

## Pendencias na primeira build
- Validar nomes de pacotes e a URL do tema XP (`scripts/xp-theme.sh`).
- Ajustar o painel XFCE (barra embaixo + menu Whisker como "Iniciar").
- Criar wallpaper, icone e logo proprios (nao use assets da Microsoft).
