
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

