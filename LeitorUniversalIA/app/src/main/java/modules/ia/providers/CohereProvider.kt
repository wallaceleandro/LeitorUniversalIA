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
