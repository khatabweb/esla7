import 'AnimatedWidgets.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  final String? image;
  const PhotoScreen({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      duration: 1,
      verticalOffset: 50,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          child: Hero(
            tag: "imageHero",
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("$image"),
                    fit: BoxFit.contain,
                  )
                ),
              ),
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
