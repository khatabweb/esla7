import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenterLoading extends StatelessWidget {
  final double? size;
  final Color? color;
  CenterLoading({this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SpinKitDualRing(
        size: size ?? 25,
        lineWidth: 3,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}