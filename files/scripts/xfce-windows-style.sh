#!/usr/bin/env bash
# Deixa o XFCE com jeito de Windows: barra embaixo, botao Iniciar,
# botoes de janela a direita, icones na area de trabalho e Thunar em lista.
# Sao padroes para usuarios novos; quem ja tem ~/.config/xfce4 mantem o proprio.
set -euxo pipefail

X="${ROOT:-}/etc/xdg/xfce4/xfconf/xfce-perchannel-xml"
P="${ROOT:-}/etc/xdg/xfce4/panel"
mkdir -p "$X" "$P"

# Barra de tarefas embaixo: Iniciar | janelas abertas | bandeja, volume e relogio
cat > "$X/xfce4-panel.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
    <property name="panel-1" type="empty">
      <property name="position" type="string" value="p=10;x=0;y=0"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="size" type="uint" value="36"/>
      <property name="icon-size" type="uint" value="24"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
        <value type="int" value="5"/>
        <value type="int" value="6"/>
      </property>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="whiskermenu"/>
    <property name="plugin-2" type="string" value="tasklist">
      <property name="grouping" type="uint" value="0"/>
      <property name="show-labels" type="bool" value="true"/>
      <property name="flat-buttons" type="bool" value="false"/>
    </property>
    <property name="plugin-3" type="string" value="separator">
      <property name="expand" type="bool" value="true"/>
      <property name="style" type="uint" value="0"/>
    </property>
    <property name="plugin-4" type="string" value="systray"/>
    <property name="plugin-5" type="string" value="pulseaudio"/>
    <property name="plugin-6" type="string" value="clock">
      <property name="digital-time-format" type="string" value="%H:%M"/>
    </property>
  </property>
</channel>
XML

# Botao Iniciar
cat > "$P/whiskermenu-1.rc" <<'RC'
button-title=Iniciar
show-button-title=true
show-button-icon=true
RC

# Janelas: titulo a esquerda, botoes Ocultar/Maximizar/Fechar a direita
cat > "$X/xfwm4.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="theme" type="string" value="MK-X-Luna"/>
    <property name="button_layout" type="string" value="O|HMC"/>
    <property name="title_alignment" type="string" value="left"/>
    <property name="double_click_action" type="string" value="maximize"/>
    <property name="snap_to_border" type="bool" value="true"/>
    <property name="tile_on_move" type="bool" value="true"/>
    <property name="use_compositing" type="bool" value="false"/>
  </property>
</channel>
XML

# Tema dos aplicativos
cat > "$X/xsettings.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="MK-X-Luna"/>
  </property>
</channel>
XML

# Area de trabalho: Pasta pessoal, Lixeira, Sistema de arquivos e discos removiveis
cat > "$X/xfce4-desktop.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="desktop-icons" type="empty">
    <property name="style" type="uint" value="2"/>
    <property name="icon-size" type="uint" value="48"/>
    <property name="single-click" type="bool" value="false"/>
    <property name="file-icons" type="empty">
      <property name="show-home" type="bool" value="true"/>
      <property name="show-filesystem" type="bool" value="true"/>
      <property name="show-trash" type="bool" value="true"/>
      <property name="show-removable" type="bool" value="true"/>
    </property>
  </property>
</channel>
XML

# Gerenciador de arquivos: lista detalhada, duplo clique, pastas primeiro
cat > "$X/thunar.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="thunar" version="1.0">
  <property name="last-view" type="string" value="ThunarDetailsView"/>
  <property name="misc-single-click" type="bool" value="false"/>
  <property name="misc-folders-first" type="bool" value="true"/>
  <property name="misc-full-path-in-title" type="bool" value="true"/>
</channel>
XML
