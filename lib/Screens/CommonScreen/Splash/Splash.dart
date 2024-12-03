import 'dart:async';
import 'package:esla7/Screens/Widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  final Widget? screen;

  SplashScreen({this.screen});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => widget.screen!),
            (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CustomLogo(size: 160,verticalOffset: 150),
      )
    );
  }
}
