package modules.ia.offline

import java.io.File
import java.net.URL

class ModelManager {

    private val pastaModelos = "models"

    fun modeloExiste(nome: String): Boolean {

        val arquivo = File("$pastaModelos/$nome")

        return arquivo.exists()
    }

    fun baixarModelo(nome: String, url: String) {

        val destino = File("$pastaModelos/$nome")

        if (!destino.exists()) {

            println("Baixando modelo: $nome")

            URL(url).openStream().use { input ->
                destino.outputStream().use { output ->
                    input.copyTo(output)
                }
            }

            println("Download concluído")
        }
    }
}
