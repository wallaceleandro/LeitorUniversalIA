package modules.ia.offline

data class ModeloIA(
    val nome: String,
    val url: String
)

object ModelRegistry {

    val modelos = listOf(

        ModeloIA(
            "voz_model.bin",
            "https://example.com/models/voz_model.bin"
        ),

        ModeloIA(
            "texto_model.bin",
            "https://example.com/models/texto_model.bin"
        )
    )
}
