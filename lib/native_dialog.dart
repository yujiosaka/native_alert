import 'dart:async';

import 'package:flutter/services.dart';

class NativeDialog {
  static const MethodChannel _channel = MethodChannel('native_dialog');

  static Future<void> alert(String message) async {
    await _channel.invokeMethod<void>('alert', [message]);
  }

  static Future<bool> confirm(String message) async {
    final result = await _channel.invokeMethod<bool>('confirm', [message]);
    return result ?? false;
  }
}
