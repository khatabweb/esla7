import 'Custom_Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView({Key? key}) : super(key: key);

  final List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.tealAccent,
    Colors.purple,
    Colors.lightGreen,
    Colors.brown
  ];
  final List<String> images = [
    "assets/images/a1.jpg",
    "assets/images/a2.jpg",
    "assets/images/a3.jpg",
    "assets/images/a4.jpg",
    "assets/images/a5.jpg",
    "assets/images/a6.jpg",
  ];

  final List<String> titles = [
    "صيانة المصاعد",
    "صيانة الموبايلات",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 3 : 3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: 2,
        itemBuilder: (_, index) {
          return CustomSection(
            image: "",
          );
        },
      ),
    );
  }
}
