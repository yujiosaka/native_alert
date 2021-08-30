import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_dialog/native_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NativeDialog', () {
    const MethodChannel channel = MethodChannel('native_dialog');
    const Map<String, dynamic> defaultResponses = { 'alert': null, 'confirm': true };

    final PlatformException exception = PlatformException(code: "UNAVAILABLE", message: "Native alert is unavailable");
    final List<MethodCall> log = <MethodCall>[];

    late Map<String, dynamic> responses;

    setUp(() {
      responses = Map<String, dynamic>.from(defaultResponses);
      channel.setMockMethodCallHandler((MethodCall methodCall) {
        log.add(methodCall);
        final dynamic response = responses[methodCall.method];
        if (response != null && response is Exception) {
          return Future<dynamic>.error('$response');
        }
        return Future<dynamic>.value(response);
      });
      log.clear();
    });

    tearDown(() {
      log.clear();
      channel.setMockMethodCallHandler(null);
    });

    group('alert', () {
      test('invokes correct method', () async {
        await NativeDialog.alert('Oops, something went wrong!');
        expect(log, [isMethodCall('alert', arguments: ['Oops, something went wrong!'])]);
      });

      test('dismisses', () async {
        responses['alert'] = null;

        await NativeDialog.alert('Hoge');
      });

      test('fails', () async {
        responses['alert'] = exception;

        expect(NativeDialog.alert('Hoge'), throwsA(isInstanceOf<PlatformException>()));
      });
    });

    group('confirm', () {
      test('invokes correct method', () async {
        await NativeDialog.confirm('Do you really want to leave?');
        expect(log, [isMethodCall('confirm', arguments: ['Do you really want to leave?'])]);
      });

      test('confirms', () async {
        responses['confirm'] = true;

        final bool confirmed = await NativeDialog.confirm('Hoge');
        expect(confirmed, isTrue);
      });

      test('dismisses', () async {
        responses['confirm'] = false;

        final bool confirmed = await NativeDialog.confirm('Hoge');
        expect(confirmed, isFalse);
      });

      test('fails', () async {
        responses['confirm'] = exception;

        expect(NativeDialog.confirm('Hoge'), throwsA(isInstanceOf<PlatformException>()));
      });
    });
  });
}
