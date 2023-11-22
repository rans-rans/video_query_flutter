package com.flutlin.video_player

import android.content.Context
import android.provider.MediaStore

class VideoQuery {

    fun getVideoFiles(context: Context): List<Map<*, *>> {
        val contentResolver = context.contentResolver
        val provider = contentResolver.query(
            MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
            arrayOf(
                MediaStore.Video.Media.DATA,
                MediaStore.Video.Media.DURATION,
                MediaStore.Video.Media.DISPLAY_NAME,
            ),
            null,
            null,
            MediaStore.Video.Media.DEFAULT_SORT_ORDER
        )
        val videoFiles = mutableListOf<Map<*, *>>()
        if (provider != null) {
            while (provider.moveToNext()) {
                val filePath =
                    provider.getString(provider.getColumnIndexOrThrow(MediaStore.Video.Media.DATA))
                val name =
                    provider.getString(provider.getColumnIndexOrThrow(MediaStore.Video.Media.DISPLAY_NAME))
                val duration =
                    provider.getString(provider.getColumnIndexOrThrow(MediaStore.Video.Media.DURATION))


                videoFiles.add(
                    mapOf(
                        "name" to name,
                        "path" to filePath,
                        "duration" to duration,
                    )
                )
            }
            provider.close()
        }
        return videoFiles
    }

}
