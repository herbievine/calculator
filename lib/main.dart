import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home.dart';
import 'screens/settings.dart';

import 'theme/style.dart';

Styles styles = new Styles();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: styles.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
      },
    );
  }
}

