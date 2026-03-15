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
