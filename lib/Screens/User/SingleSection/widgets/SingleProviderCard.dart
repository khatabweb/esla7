import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class SingleProviderCard extends StatelessWidget {
  final bool? isGolden;
  final VoidCallback? onTap;
  final String? image;
  final String? name;
  final String? city;
  final String? serviceName;
  final int? rate;

  const SingleProviderCard({
    Key? key,
    this.isGolden,
    this.onTap,
    this.image,
    this.name,
    this.city,
    this.serviceName,
    this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.15,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isGolden == true ? ThemeColor.mainGold : Colors.white, width: 1.5)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRoundedPhoto(
              image: "$image", //"assets/images/profile.jpg",
              radius: 32,
              borderWidth: 1.5,
              borderColor: isGolden == true
                  ? ThemeColor.mainGold
                  : Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawHeaderText(
                    text: "$name", //"احمد محمد حسين",
                    fontSize: 14,
                    color: isGolden == true
                        ? ThemeColor.mainGold
                        : Theme.of(context).primaryColor,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        child: Center(
                          child: Image.asset(
                            "assets/icons/location.png",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      DrawHeaderText(text: "$city", fontSize: 14),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawHeaderText(
                  text: "$serviceName",
                  fontSize: translator.activeLanguageCode == "ar" ? 13 : 12,
                ),
                RatingBar.builder(
                  initialRating: rate!.toDouble(),
                  itemSize: 20,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ignoreGestures: true,
                  unratedColor: Colors.grey[300],
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1),
                  itemBuilder: (context, _) {
                    return Image.asset(
                      "assets/icons/star.png",
                      color: ThemeColor.mainGold,
                    );
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}