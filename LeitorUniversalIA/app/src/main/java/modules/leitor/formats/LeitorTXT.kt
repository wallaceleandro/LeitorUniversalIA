package modules.leitor.formats

import java.io.File

object LeitorTXT {

    fun lerArquivo(caminho: String): String {
        return File(caminho).readText()
    }
}
