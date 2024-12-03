import 'package:flutter/material.dart';

class CenterMessage extends StatelessWidget {
  final String msg;
  final Color? textColor;

  CenterMessage(this.msg, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: TextStyle(
          color: textColor ?? Theme.of(context).primaryColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
