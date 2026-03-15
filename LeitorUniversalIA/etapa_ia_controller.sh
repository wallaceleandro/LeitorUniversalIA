#!/bin/bash

echo "======================================"
echo "CRIANDO IA CONTROLLER - LeitorUniversalIA"
echo "======================================"

APP_DIR="app/src/main"

echo "Criando diretórios da IA..."

mkdir -p $APP_DIR/java/modules/ia/controller
mkdir -p $APP_DIR/java/modules/ia/providers
mkdir -p $APP_DIR/java/modules/ia/models

echo "Criando modelo de resposta da IA..."

cat > $APP_DIR/java/modules/ia/models/IAResponse.kt << 'EOF'
package modules.ia.models

data class IAResponse(
    val sucesso: Boolean,
    val resposta: String,
    val provedor: String
)
EOF

echo "Criando interface padrão para provedores..."

cat > $APP_DIR/java/modules/ia/providers/IAProvider.kt << 'EOF'
package modules.ia.providers

import modules.ia.models.IAResponse

interface IAProvider {

    fun nome(): String

    fun gerarResposta(pergunta: String): IAResponse
}
EOF

echo "Criando provedor Cohere..."

cat > $APP_DIR/java/modules/ia/providers/CohereProvider.kt << 'EOF'
package modules.ia.providers

import modules.ia.models.IAResponse

class CohereProvider : IAProvider {

    override fun nome(): String {
        return "Cohere"
    }

    override fun gerarResposta(pergunta: String): IAResponse {

        try {

            // aqui futuramente entra chamada real da API

            val resposta = "Resposta simulada do Cohere para: $pergunta"

            return IAResponse(true, resposta, nome())

        } catch (e: Exception) {

            return IAResponse(false, "", nome())

        }
    }
}
EOF

echo "Criando provedor IA local..."

cat > $APP_DIR/java/modules/ia/providers/LocalProvider.kt << 'EOF'
package modules.ia.providers

import modules.ia.models.IAResponse

class LocalProvider : IAProvider {

    override fun nome(): String {
        return "LocalIA"
    }

    override fun gerarResposta(pergunta: String): IAResponse {

        val resposta = "Resposta básica offline para: $pergunta"

        return IAResponse(true, resposta, nome())
    }
}
EOF

echo "Criando IA Controller..."

cat > $APP_DIR/java/modules/ia/controller/IAController.kt << 'EOF'
package modules.ia.controller

import modules.ia.models.IAResponse
import modules.ia.providers.*

class IAController {

    private val provedores = listOf(
        CohereProvider(),
        LocalProvider()
    )

    fun perguntar(texto: String): IAResponse {

        for (provedor in provedores) {

            val resposta = provedor.gerarResposta(texto)

            if (resposta.sucesso) {

                return resposta

            }
        }

        return IAResponse(
            false,
            "Nenhuma IA disponível",
            "none"
        )
    }
}
EOF

echo "======================================"
echo "IA CONTROLLER CRIADO"
echo "======================================"

echo "Funções:"
echo "✔ estrutura para múltiplas IAs"
echo "✔ fallback automático"
echo "✔ IA offline de segurança"
echo "✔ fácil adicionar novas APIs"

echo "Script finalizado."
