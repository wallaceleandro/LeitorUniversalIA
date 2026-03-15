package com.leitor.universal

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.github.barteksc.pdfviewer.PDFView

class LeitorActivity : AppCompatActivity() {

override fun onCreate(savedInstanceState: Bundle?) {

super.onCreate(savedInstanceState)

setContentView(R.layout.activity_leitor)

val pdfView = findViewById<PDFView>(R.id.pdfView)

pdfView.fromAsset("livro.pdf")
.enableSwipe(true)
.enableDoubletap(true)
.load()

}
}
