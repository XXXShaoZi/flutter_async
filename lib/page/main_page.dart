import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MailPageState();
  }
}

class _MailPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MainPage"),
        ),
        body: ListView(
          children: [
            MaterialButton(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    height: 38,
                    color: Colors.red,
                    child: Center(
                      child: Text("IsolateCase1"),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/isolateCase1");
                }),
            MaterialButton(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    height: 38,
                    color: Colors.red,
                    child: Center(
                      child: Text("IsolateCase2"),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/isolateCase2");
                })
          ],
        ));
  }
}
