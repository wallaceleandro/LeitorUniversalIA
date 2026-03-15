#!/bin/bash

PROJETO="LeitorUniversalIA"

echo "Instalando sistema modular..."

cd $PROJETO || exit

# ===============================
# Função segura
# ===============================

criar_file_seguro() {
if [ ! -f "$1" ]; then
touch "$1"
echo "Criado $1"
fi
}

criar_dir_seguro() {
if [ ! -d "$1" ]; then
mkdir -p "$1"
echo "Criado $1"
fi
}

# ===============================
# CORE DO SISTEMA
# ===============================

criar_dir_seguro "core/system"
criar_dir_seguro "core/modules"
criar_dir_seguro "core/ui"
criar_dir_seguro "core/loader"

criar_file_seguro "core/system/app_core.md"
criar_file_seguro "core/system/module_controller.md"
criar_file_seguro "core/loader/module_loader.md"

# ===============================
# REGISTRO DE MÓDULOS
# ===============================

REGISTRY="config/module_registry.md"

echo "Criando registro de módulos..."

cat > $REGISTRY << 'EOF'

# REGISTRO CENTRAL DE MÓDULOS

Formato:

NOME | STATUS | DESCRIÇÃO

reader | ativo | leitor universal
cnh | ativo | simulador CNH
video | ativo | criação e edição de vídeo
image | ativo | criação e edição de imagens
converter | ativo | conversor universal de mídia
editor | ativo | ferramentas gerais
translator | ativo | tradutor global
knowledge | ativo | base de conhecimento

EOF

echo "Registro criado."

# ===============================
# SISTEMA DE BOTÕES DA UI
# ===============================

criar_dir_seguro "core/ui/buttons"

criar_file_seguro "core/ui/buttons/reader_button.md"
criar_file_seguro "core/ui/buttons/cnh_button.md"
criar_file_seguro "core/ui/buttons/video_button.md"
criar_file_seguro "core/ui/buttons/image_button.md"
criar_file_seguro "core/ui/buttons/converter_button.md"

# ===============================
# SISTEMA DE TEMA DINÂMICO
# ===============================

criar_dir_seguro "core/ui/theme_engine"

criar_file_seguro "core/ui/theme_engine/theme_controller.md"
criar_file_seguro "core/ui/theme_engine/font_manager.md"
criar_file_seguro "core/ui/theme_engine/color_manager.md"

# ===============================
# SISTEMA DE LOG
# ===============================

criar_dir_seguro "logs/system"

criar_file_seguro "logs/system/module_loader.log"

# ===============================
# SISTEMA DE EXTENSÃO FUTURA
# ===============================

criar_dir_seguro "extensions"

criar_file_seguro "extensions/plugin_system.md"

# ===============================
# DOCUMENTAÇÃO DO CORE
# ===============================

DOC="docs/modular_system.md"

cat > $DOC << 'EOF'

# Sistema Modular do LeitorUniversalIA

Todos os módulos funcionam de forma independente.

Estrutura:

core
modules
ai
media
voice
layout

Para adicionar novo módulo:

1 criar pasta em modules
2 registrar em config/module_registry.md
3 criar botão em core/ui/buttons
4 conectar à IA central

Nenhum módulo deve depender diretamente de outro.

EOF

echo "Sistema modular instalado."

echo ""
echo "Projeto agora suporta expansão segura."
