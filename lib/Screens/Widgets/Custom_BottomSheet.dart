import 'package:flutter/material.dart';

void customSheet({BuildContext? context, Widget? widget, double? height}) {
  showModalBottomSheet(
      context: context!,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 15),
                    child: widget,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}