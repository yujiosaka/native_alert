import 'dart:async';
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class NativeDialogWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'native_dialog',
      const StandardMethodCodec(),
      registrar,
    );

    final NativeDialogWeb pluginInstance = NativeDialogWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'alert':
        final message = getMessage(call.arguments);
        return alert(message);
      case 'confirm':
        final message = getMessage(call.arguments);
        return confirm(message);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'native_dialog for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  String getMessage(List arguments) {
    return arguments.first as String;
  }

  Future<void> alert(String message) {
    html.window.alert(message);
    return Future.value();
  }

  Future<bool> confirm(String message) {
    final bool result = html.window.confirm(message);
    return Future.value(result);
  }
}
