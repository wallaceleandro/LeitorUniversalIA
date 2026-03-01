package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.leitoruniversalia.leitor.LeitorActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btnLeitor = findViewById<Button>(R.id.btnLeitor)

        btnLeitor.setOnClickListener {
            val intent = Intent(this, LeitorActivity::class.java)
            startActivity(intent)
        }
    }
}
