import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget? child;

  const CustomBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.5),
            Theme.of(context).primaryColor.withOpacity(0.4),
            Theme.of(context).primaryColor.withOpacity(0.3),
            Theme.of(context).primaryColor.withOpacity(0.2),
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
            // Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child ?? SizedBox(),
    );
  }
}