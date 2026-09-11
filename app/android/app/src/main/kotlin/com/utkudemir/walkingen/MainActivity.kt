package com.utkudemir.walkingen

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "walkingen/location"

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        val requestedPermissions = buildList {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q &&
                checkSelfPermission(Manifest.permission.ACTIVITY_RECOGNITION) != PackageManager.PERMISSION_GRANTED
            ) {
                add(Manifest.permission.ACTIVITY_RECOGNITION)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
                checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED
            ) {
                add(Manifest.permission.POST_NOTIFICATIONS)
            }
        }
        if (requestedPermissions.isNotEmpty()) {
            requestPermissions(requestedPermissions.toTypedArray(), 1001)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateForegroundNotification" -> {
                        val title = call.argument<String>("title")
                            ?: return@setMethodCallHandler result.error(
                                "MISSING_TITLE",
                                "Notification title is required.",
                                null,
                            )
                        val channelName = call.argument<String>("channelName") ?: title
                        val text = call.argument<String>("text") ?: ""
                        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
                        val pendingIntent = launchIntent?.let {
                            PendingIntent.getActivity(
                                this,
                                0,
                                it,
                                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                            )
                        }
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            val manager = getSystemService(NotificationManager::class.java)
                            manager?.createNotificationChannel(
                                NotificationChannel(
                                    "geolocator_channel_01",
                                    channelName,
                                    NotificationManager.IMPORTANCE_LOW,
                                ),
                            )
                        }
                        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            Notification.Builder(this, "geolocator_channel_01")
                        } else {
                            Notification.Builder(this)
                        }
                        val notification = builder
                            .setSmallIcon(android.R.drawable.ic_menu_mylocation)
                            .setContentTitle(title)
                            .setContentText(text)
                            .setContentIntent(pendingIntent)
                            .setOngoing(true)
                            .setCategory(Notification.CATEGORY_SERVICE)
                            .build()
                        getSystemService(NotificationManager::class.java)
                            ?.notify(75415, notification)
                        result.success(null)
                    }
                    "clearForegroundNotification" -> {
                        getSystemService(NotificationManager::class.java)
                            ?.cancel(75415)
                        result.success(null)
                    }
                    "stopForegroundService" -> {
                        val intent = Intent().setClassName(
                            packageName,
                            "com.baseflow.geolocator.GeolocatorLocationService",
                        )
                        stopService(intent)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
