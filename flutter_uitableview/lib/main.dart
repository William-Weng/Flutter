import 'package:flutter/material.dart';
import 'package:flutter_uitableview/widgets/LoginPage.dart';
import 'package:flutter_uitableview/widgets/HomePage.dart';
import 'helpers/Constants.dart';

void main() => runApp(MyTableViewApp());

class MyTableViewApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
