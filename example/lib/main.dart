import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_dialog/native_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _textEditingController;
  String _message = 'Hello World!';
  bool _confirmed = false;

  @override
  void initState() {
    _textEditingController = new TextEditingController(text: _message);
    super.initState();
  }

  void _handleMessage(String value) {
    setState(() {
      _message = value;
    });
  }

  Future<void> _alert() async {
    try {
      await NativeDialog.alert(_message);
    } on PlatformException catch (error) {
      print(error.message);
    }
  }

  Future<void> _confirm() async {
    bool confirmed;
    try {
      confirmed = await NativeDialog.confirm(_message);
    } on PlatformException catch (error) {
      print(error.message);
      confirmed = _confirmed;
    }

    if (!mounted) return;

    setState(() {
      _confirmed = confirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native dialog demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: "Message",
                  hintText: "Enter message here"
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: _handleMessage,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _message.isNotEmpty ? _alert : null,
                child: Text("Alert"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _message.isNotEmpty ? _confirm : null,
                child: Text("Confirm"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
              ),
            ),
            Text(_confirmed ? 'Confirmed' : 'Unconfirmed'),
          ],
        ),
      ),
    );
  }
}
