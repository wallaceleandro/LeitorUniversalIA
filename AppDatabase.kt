package com.leitoruniversalia.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [AudioText::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun audioTextDao(): AudioTextDao

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getDatabase(context: Context): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    AppDatabase::class.java,
                    "leitor_database"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}
