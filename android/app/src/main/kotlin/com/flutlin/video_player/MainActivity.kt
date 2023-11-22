package com.flutlin.video_player

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val methodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "method_channel")


        methodChannel.setMethodCallHandler { call, results ->
            when (call.method) {
                "initialize_permissions" -> {
                    PermissionHandler(this).requestPermissions()

                }

                "query_videos" -> {
                    val videos = VideoQuery().getVideoFiles(applicationContext)
                    results.success(videos)
                }

            }
        }
    }
}
