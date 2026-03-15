exports.perguntar = async (req, res) => {

    const pergunta = req.body.pergunta

    try {

        const resposta = "Resposta simulada da IA para: " + pergunta

        res.json({
            sucesso: true,
            resposta: resposta
        })

    } catch (error) {

        res.json({
            sucesso: false,
            erro: "Falha na IA"
        })
    }
}
