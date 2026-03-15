#!/bin/bash

echo "======================================"
echo "CRIANDO BACKEND API - LeitorUniversalIA"
echo "======================================"

BACKEND_DIR="backend"

echo "Criando estrutura do backend..."

mkdir -p $BACKEND_DIR
mkdir -p $BACKEND_DIR/controllers
mkdir -p $BACKEND_DIR/services
mkdir -p $BACKEND_DIR/routes
mkdir -p $BACKEND_DIR/config

cd $BACKEND_DIR

echo "Criando package.json..."

cat > package.json << 'EOF'
{
  "name": "leitor-universal-ia-api",
  "version": "1.0.0",
  "description": "API do projeto LeitorUniversalIA",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "axios": "^1.6.0",
    "dotenv": "^16.3.1"
  }
}
EOF

echo "Criando servidor principal..."

cat > server.js << 'EOF'
const express = require("express")
const cors = require("cors")

const iaRoutes = require("./routes/iaRoutes")

const app = express()

app.use(cors())
app.use(express.json())

app.use("/ia", iaRoutes)

app.get("/", (req, res) => {
    res.json({
        status: "API LeitorUniversalIA online"
    })
})

const PORT = process.env.PORT || 3000

app.listen(PORT, () => {
    console.log("Servidor rodando na porta " + PORT)
})
EOF

echo "Criando rotas da IA..."

cat > routes/iaRoutes.js << 'EOF'
const express = require("express")
const router = express.Router()

const iaController = require("../controllers/iaController")

router.post("/perguntar", iaController.perguntar)

module.exports = router
EOF

echo "Criando controller da IA..."

cat > controllers/iaController.js << 'EOF'
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
EOF

echo "Criando configuração do Supabase..."

cat > config/supabase.js << 'EOF'
const { createClient } = require('@supabase/supabase-js')

const supabaseUrl = process.env.SUPABASE_URL
const supabaseKey = process.env.SUPABASE_KEY

const supabase = createClient(supabaseUrl, supabaseKey)

module.exports = supabase
EOF

echo "Criando arquivo de variáveis de ambiente..."

cat > .env << 'EOF'
SUPABASE_URL=COLOQUE_AQUI
SUPABASE_KEY=COLOQUE_AQUI
EOF

echo "======================================"
echo "BACKEND CRIADO"
echo "======================================"

echo "Funções disponíveis:"
echo "✔ API REST"
echo "✔ endpoint /ia/perguntar"
echo "✔ estrutura para IA"
echo "✔ conexão futura com Supabase"
echo "✔ pronto para Render"

echo "Script finalizado."
