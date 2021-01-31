import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolateCase2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IsolateCase2State();
  }
}

class _IsolateCase2State extends State<IsolateCase2> {

  static String _togetherValue = "";

  ReceivePort receivePort1;
  ReceivePort receivePort2;

  @override
  void initState() {
    super.initState();

    receivePort1 = ReceivePort();
    receivePort1.listen((message) {
      print("receivePort2-$message");
      if (message is SendPort) {
        setState(() {
          _togetherValue = "receivePort2";
        });
        message.send(receivePort1.sendPort);
      } else {
        setState(() {});
      }
    });
    Isolate.spawn(onStart, receivePort1.sendPort);
  }

  static void onStart(SendPort sendPort) {
    ReceivePort receivePort2 = ReceivePort();
    receivePort2.listen((message) {
      print("receivePort1-$message");
      _togetherValue = "receivePort2";
      // 通知port1 setState
      sendPort.send("setState");
      receivePort2.close();
    });
    sendPort.send(receivePort2.sendPort);
  }

  @override
  void dispose() {
    receivePort1.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IsolateCase2")),
      body: Text(_togetherValue),
    );
  }
}
