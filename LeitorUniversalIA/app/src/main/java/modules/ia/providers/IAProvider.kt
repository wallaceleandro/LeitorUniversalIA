package modules.ia.providers

import modules.ia.models.IAResponse

interface IAProvider {

    fun nome(): String

    fun gerarResposta(pergunta: String): IAResponse
}
