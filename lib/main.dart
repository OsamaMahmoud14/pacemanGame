import 'package:flutter/material.dart';
import 'package:pacemanlink/splash.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splash(),
      debugShowCheckedModeBanner: false,
    );
  }

}