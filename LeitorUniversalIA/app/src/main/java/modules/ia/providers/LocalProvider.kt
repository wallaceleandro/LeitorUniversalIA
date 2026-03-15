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
