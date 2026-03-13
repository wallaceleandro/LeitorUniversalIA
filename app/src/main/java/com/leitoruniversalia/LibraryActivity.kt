package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.*
import android.content.SharedPreferences

class LibraryActivity:AppCompatActivity(){

lateinit var list:ListView

override fun onCreate(savedInstanceState:Bundle?){

super.onCreate(savedInstanceState)

setContentView(R.layout.activity_library)

list=findViewById(R.id.bookList)

val prefs=getSharedPreferences("books",MODE_PRIVATE)

val books=prefs.all.keys.toList()

val adapter=ArrayAdapter(this,android.R.layout.simple_list_item_1,books)

list.adapter=adapter

list.setOnItemClickListener{_,_,pos,_ ->

val book=books[pos]

val intent=Intent(this,MainActivity::class.java)

intent.putExtra("BOOK_PATH",prefs.getString(book,""))

startActivity(intent)

}

}

}
