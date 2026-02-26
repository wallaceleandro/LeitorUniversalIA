package com.leitoruniversalia

import android.app.Activity
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.provider.OpenableColumns
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import java.io.File
import java.io.InputStream
import java.io.OutputStream

class LeitorActivity : AppCompatActivity() {

    private lateinit var editText: EditText
    private lateinit var btnReadText: Button
    private lateinit var btnAudio: Button
    private lateinit var btnCopy: Button
    private lateinit var btnSave: Button
    private lateinit var btnImage: Button
    private lateinit var txtTitulo: TextView
    private var imageUri: Uri? = null

    private val pickImage =
        registerForActivityResult(ActivityResultContracts.GetContent()) { uri: Uri? ->
            uri?.let {
                imageUri = it
                val inputStream: InputStream? = contentResolver.openInputStream(uri)
                val bitmap = BitmapFactory.decodeStream(inputStream)
                window.decorView.background = android.graphics.drawable.BitmapDrawable(resources, bitmap)
                inputStream?.close()
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)
        btnAudio = findViewById(R.id.btnAudio)
        btnCopy = findViewById(R.id.btnCopy)
        btnSave = findViewById(R.id.btnSave)
        btnImage = findViewById(R.id.btnImage)
        txtTitulo = findViewById(R.id.txtTitulo)

        // Ler texto (aqui você vai chamar TTS IA depois)
        btnReadText.setOnClickListener {
            val texto = editText.text.toString()
            if (texto.isNotEmpty()) {
                Toast.makeText(this, "Lendo texto: $texto", Toast.LENGTH_SHORT).show()
                // Aqui será implementada a IA de voz real
            } else {
                Toast.makeText(this, "Texto vazio", Toast.LENGTH_SHORT).show()
            }
        }

        // Usar áudio existente
        btnAudio.setOnClickListener {
            Toast.makeText(this, "Escolher áudio do telefone", Toast.LENGTH_SHORT).show()
            // Implementar reprodução do áudio escolhido
        }

        // Copiar texto
        btnCopy.setOnClickListener {
            val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
            val clip = ClipData.newPlainText("texto", editText.text.toString())
            clipboard.setPrimaryClip(clip)
            Toast.makeText(this, "Texto copiado", Toast.LENGTH_SHORT).show()
        }

        // Salvar texto
        btnSave.setOnClickListener {
            val fileName = "leitura.txt"
            try {
                openFileOutput(fileName, Context.MODE_PRIVATE).use { output: OutputStream ->
                    output.write(editText.text.toString().toByteArray())
                }
                Toast.makeText(this, "Texto salvo em $fileName", Toast.LENGTH_SHORT).show()
            } catch (e: Exception) {
                Toast.makeText(this, "Erro ao salvar: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        }

        // Escolher imagem/fundo
        btnImage.setOnClickListener {
            pickImage.launch("image/*")
        }
    }
}
