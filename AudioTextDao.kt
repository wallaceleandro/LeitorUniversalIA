package com.leitoruniversalia.data

import androidx.room.*
import kotlinx.coroutines.flow.Flow

@Dao
interface AudioTextDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(item: AudioText)

    @Update
    suspend fun update(item: AudioText)

    @Delete
    suspend fun delete(item: AudioText)

    @Query("SELECT * FROM audio_text_table ORDER BY id DESC")
    fun getAll(): Flow<List<AudioText>>
}
