import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolateCase1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IsolateCase1State();
  }
}

class _IsolateCase1State extends State<IsolateCase1> {
  List<String> _list = [];

  static ReceivePort newIsolateReceivePort;
  static SendPort mainSendPort;

  ReceivePort mainReceivePort;
  SendPort newIsolateSendPort;

  @override
  void initState() {
    super.initState();
    mainReceivePort = ReceivePort();
    Isolate.spawn(subIsolateEntry, mainReceivePort.sendPort);
    mainReceivePort.listen(_onReceiveMessage);
  }

  // 主isolate的消息处理函数
  void _onReceiveMessage(message) {
    if (message is SendPort) {
      newIsolateSendPort = message;
    } else {
      setState(() {
        _list.add(message.toString());
      });
    }
  }

  // entryPoint函数
  // 需要注意的是，按照要求，entryPoint必须为顶级函数或者静态函数
  // 该函数为另外一个线程的入口函数
  static void subIsolateEntry(var message) {
    newIsolateReceivePort = ReceivePort();
    newIsolateReceivePort.listen(onReceiveMessage);
    mainSendPort = message;
    mainSendPort.send(newIsolateReceivePort.sendPort);
  }

// new Isolate的消息处理函数
  static void onReceiveMessage(message) {
    print(message);
    if (message == "close") {
      // 当收到close消息时，关闭newIsolateReceivePort
      newIsolateReceivePort.close();
      return;
    }
    // 模拟执行耗时任务，执行完成返回结果到配对的
    for (int i = 1; i <= message; i++) {
      // 耗时任务 5s
      sleep(Duration(seconds: 1));
      mainSendPort.send("---$i---");
    }
  }

  @override
  void dispose() {
    mainReceivePort.close();
    newIsolateSendPort.send("close");
    super.dispose();
  }

  void _sendPort() {
    if (newIsolateSendPort != null) {
      newIsolateSendPort.send(10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IsolateCase1")),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    height:100,
                    color: Colors.lightBlueAccent,
                    child: Center(
                      child: Text(_list[index]),
                    )));
          },
          itemCount: _list.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _sendPort,
      ),
    );
  }
}
