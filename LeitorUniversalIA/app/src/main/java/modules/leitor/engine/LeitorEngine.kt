package modules.leitor.engine

class LeitorEngine {

    private var paginaAtual = 1
    private var totalPaginas = 1

    fun definirTotalPaginas(total: Int) {
        totalPaginas = total
    }

    fun proximaPagina(): Int {
        if (paginaAtual < totalPaginas) {
            paginaAtual++
        }
        return paginaAtual
    }

    fun paginaAnterior(): Int {
        if (paginaAtual > 1) {
            paginaAtual--
        }
        return paginaAtual
    }

    fun obterPaginaAtual(): Int {
        return paginaAtual
    }

    fun obterTotalPaginas(): Int {
        return totalPaginas
    }

    fun porcentagem(): Int {
        return (paginaAtual * 100) / totalPaginas
    }
}
