import 'dart:async';
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class NativeDialogWeb {
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel(
      'native_dialog',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = NativeDialogWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'alert':
        final message = _getMessage(call.arguments);
        return _alert(message);
      case 'confirm':
        final message = _getMessage(call.arguments);
        return _confirm(message);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "native_dialog for web doesn't implement '${call.method}'",
        );
    }
  }

  String _getMessage(dynamic arguments) {
    return arguments.first as String;
  }

  Future<void> _alert(String message) {
    html.window.alert(message);
    return Future.value();
  }

  Future<bool> _confirm(String message) {
    final result = html.window.confirm(message);
    return Future.value(result);
  }
}
