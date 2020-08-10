import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  String status = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // try asking for permission on first app launch
      askForPermission(Permission.storage);
    });
  }

  Future<void> askForPermission(Permission permission) async {
    var permStatus = await permission.status;
    if (!permStatus.isGranted)
      permStatus = await permission.request();
    setState(() => status = '${permission.toString()} = $permStatus');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(status)
            ],
          ),
        )
      ),
    );
  }
}
