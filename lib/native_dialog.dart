
import 'dart:async';

import 'package:flutter/services.dart';

class NativeDialog {
  static const MethodChannel _channel = const MethodChannel('native_dialog');

  static Future<void> alert(String message) async {
    await _channel.invokeMethod('alert', [message]);
  }

  static Future<bool> confirm(String message) async {
    final bool result = await _channel.invokeMethod('confirm', [message]);
    return result;
  }
}
