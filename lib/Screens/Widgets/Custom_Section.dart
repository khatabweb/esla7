import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'AnimatedWidgets.dart';
import 'Custom_DrawText.dart';

class CustomSection extends StatelessWidget {
  final String image;
  final String? title;
  final void Function()? onTap;
  final bool? soon;

  CustomSection({this.title, required this.image, this.onTap, this.soon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedWidgets(
        verticalOffset: 150,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Center(
                        child: CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              if (!image.contains("http")) {
                                return Image.asset(image);
                              } else {
                                return Icon(Icons.error);
                              }
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: DrawHeaderText(
                        text: title ?? "",
                        color: Theme.of(context).primaryColor,
                        fontSize: 13),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                right: 20,
                child: soon == true
                    ? Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/icons/soon.png"),
                          fit: BoxFit.contain,
                        )),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
