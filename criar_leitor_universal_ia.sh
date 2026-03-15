#!/bin/bash

# ===============================================
#  GERADOR DO PROJETO: LEITOR UNIVERSAL IA
#  Estrutura modular expansível
# ===============================================

PROJETO="LeitorUniversalIA"

echo "Criando estrutura do projeto $PROJETO..."

# função segura de criação
criar_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Criado: $1"
    else
        echo "Existe: $1"
    fi
}

criar_file() {
    if [ ! -f "$1" ]; then
        touch "$1"
        echo "Criado: $1"
    else
        echo "Existe: $1"
    fi
}

# ===============================
# Estrutura principal
# ===============================

criar_dir "$PROJETO"

cd "$PROJETO"

criar_dir "core"
criar_dir "modules"
criar_dir "ai"
criar_dir "media"
criar_dir "voice"
criar_dir "knowledge"
criar_dir "layout"
criar_dir "storage"
criar_dir "docs"
criar_dir "config"
criar_dir "logs"

# ===============================
# IA CENTRAL
# ===============================

criar_dir "ai/core"
criar_dir "ai/translator"
criar_dir "ai/text_correction"
criar_dir "ai/assistant"

criar_file "ai/core/ai_engine.md"
criar_file "ai/translator/global_translator.md"
criar_file "ai/text_correction/portuguese_br.md"
criar_file "ai/assistant/assistant_functions.md"

# ===============================
# BASE DE CONHECIMENTO
# ===============================

criar_dir "knowledge/offline"
criar_dir "knowledge/online"

criar_file "knowledge/offline/science.md"
criar_file "knowledge/offline/mathematics.md"
criar_file "knowledge/offline/mechanics.md"
criar_file "knowledge/offline/electrical.md"
criar_file "knowledge/offline/portuguese.md"
criar_file "knowledge/offline/traffic_rules_br.md"

# ===============================
# MÓDULOS PRINCIPAIS
# ===============================

criar_dir "modules/reader"
criar_dir "modules/cnh"
criar_dir "modules/video"
criar_dir "modules/image"
criar_dir "modules/converter"
criar_dir "modules/editor"

criar_file "modules/reader/reader_system.md"
criar_file "modules/cnh/cnh_system.md"
criar_file "modules/video/video_system.md"
criar_file "modules/image/image_system.md"
criar_file "modules/converter/media_converter.md"
criar_file "modules/editor/editor_tools.md"

# ===============================
# SISTEMA DE LEITURA
# ===============================

criar_dir "modules/reader/formats"
criar_dir "modules/reader/navigation"
criar_dir "modules/reader/progress"

criar_file "modules/reader/formats/pdf.md"
criar_file "modules/reader/formats/epub.md"
criar_file "modules/reader/formats/txt.md"
criar_file "modules/reader/formats/docx.md"

criar_file "modules/reader/navigation/page_turn.md"
criar_file "modules/reader/progress/page_counter.md"
criar_file "modules/reader/progress/percentage.md"

# ===============================
# SISTEMA DE VOZ
# ===============================

criar_dir "voice/tts"
criar_dir "voice/clone"
criar_dir "voice/record"

criar_file "voice/tts/tts_engine.md"
criar_file "voice/clone/voice_clone.md"
criar_file "voice/record/audio_input.md"

# ===============================
# MÍDIA
# ===============================

criar_dir "media/audio"
criar_dir "media/video"
criar_dir "media/image"

criar_file "media/audio/audio_formats.md"
criar_file "media/video/video_formats.md"
criar_file "media/image/image_formats.md"

# ===============================
# CONVERSOR UNIVERSAL
# ===============================

criar_dir "modules/converter/audio"
criar_dir "modules/converter/video"

criar_file "modules/converter/audio/audio_conversion.md"
criar_file "modules/converter/video/video_conversion.md"

# ===============================
# LAYOUT DINÂMICO
# ===============================

criar_dir "layout/themes"
criar_dir "layout/fonts"
criar_dir "layout/templates"

criar_file "layout/themes/dynamic_theme.md"
criar_file "layout/fonts/font_control.md"
criar_file "layout/templates/ui_templates.md"

# ===============================
# ARMAZENAMENTO
# ===============================

criar_dir "storage/books"
criar_dir "storage/audio"
criar_dir "storage/video"
criar_dir "storage/images"

# ===============================
# CONFIGURAÇÕES
# ===============================

criar_file "config/app_config.md"
criar_file "config/module_registry.md"

# ===============================
# DOCUMENTAÇÃO
# ===============================

criar_file "docs/system_architecture.md"
criar_file "docs/module_expansion_rules.md"
criar_file "docs/future_features.md"

# ===============================
# LOG
# ===============================

criar_file "logs/system_log.txt"

# ===============================
# FINAL
# ===============================

echo ""
echo "Estrutura do projeto criada com sucesso."
echo "Sistema modular pronto para expansão."
echo "Nenhum módulo depende diretamente de outro."
echo "Novos módulos podem ser adicionados sem conflito."
