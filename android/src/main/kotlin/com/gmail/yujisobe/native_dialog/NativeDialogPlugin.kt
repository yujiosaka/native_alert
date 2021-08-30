package com.gmail.yujisobe.native_dialog

import android.R
import android.app.Activity
import android.app.AlertDialog
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class NativeDialogPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_dialog")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "alert" -> {
        val message = getMessage(call.arguments)
        alert(message, result)
      }
      "confirm" -> {
        val message = getMessage(call.arguments)
        confirm(message, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  private fun getMessage(arguments: Any): String {
    return (arguments as ArrayList<*>).first() as String
  }

  private fun alert(message: String, result: Result) {
    if (activity == null) {
      result.error("UNAVAILABLE", "Native alert is unavailable", null)
      return
    }

    AlertDialog.Builder(activity)
            .setMessage(message)
            .setPositiveButton(R.string.ok) { _, _ ->
              result.success(null)
            }
            .show()
  }

  private fun confirm(message: String, result: Result) {
    if (activity == null) {
      result.error("UNAVAILABLE", "Native alert is unavailable", null)
      return
    }

    AlertDialog.Builder(activity)
            .setMessage(message)
            .setPositiveButton(R.string.ok) { _, _ ->
              result.success(true)
            }
            .setNegativeButton(R.string.cancel) { _, _ ->
              result.success(false)
            }
            .show()
  }
}
