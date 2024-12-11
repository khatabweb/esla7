import 'package:flutter/material.dart';

void customSnackBar(BuildContext? context, String error) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: "JannaLT-Regular",
        ),
      ),
    ),
  );
}
