import 'package:flutter/material.dart';
import 'package:flutter_async/page/isolate_case1.dart';
import 'package:flutter_async/page/isolate_case2.dart';
import 'package:flutter_async/page/main_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Isolate Test",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      routes: {
        "/": (BuildContext context) => MainPage(),
        "/isolateCase1": (BuildContext context) => IsolateCase1(),
        "/isolateCase2": (BuildContext context) => IsolateCase2(),
      },
      initialRoute: "/",
    );
  }
}
