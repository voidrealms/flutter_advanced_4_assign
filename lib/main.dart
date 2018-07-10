import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_permissions/simple_permissions.dart';


Permission permissionFromString(String value) {
  Permission permission;
  for(Permission item in Permission.values) {
    if(item.toString() == value) {
      permission = item;
      break;
    }
  }
  return permission;
}


void main() async {

  await SimplePermissions.requestPermission(permissionFromString('Permission.WriteExternalStorage'));
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  
  Permission permission;
  String status;


  @override
  void initState() {
    permission = permissionFromString('Permission.WriteExternalStorage');

    checkPermission();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
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