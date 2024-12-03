import 'package:flutter/material.dart';

class CountryCode extends StatelessWidget {
  late final String? countyCode;
  CountryCode({this.countyCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 1,
          height: 50,
          color: Theme.of(context).dividerColor,
        ),
        Text(
          countyCode ?? "+966",
          textDirection: TextDirection.ltr,
          style:
          TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
        ),
        SizedBox(),
      ],
    );
  }
}
