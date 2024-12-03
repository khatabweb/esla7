import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_PhotoScreen.dart';
import 'package:esla7/Screens/Widgets/Custom_RichText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class OrderItemCard extends StatelessWidget {
  final String? image;
  final String? serviceName;
  final int? quantity;
  final int? price;
  final String? note;

  const OrderItemCard({
    Key? key,
    this.image,
    this.serviceName,
    this.quantity,
    this.price,
    this.note,
  }) : super(key: key);

  // final String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 4,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _OrderItemDetails(
            image: image,
            serviceName: serviceName,
            quantity: quantity,
            price: price
          ),
          _UserNote(
            note: note,
          ),
        ],
      ),
    );
  }
}

class _OrderItemDetails extends StatelessWidget {
  final String? image;
  final String? serviceName;
  final int? quantity;
  final int? price;
  const _OrderItemDetails({Key? key, this.serviceName, this.quantity, this.price, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.12,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoScreen(image: "$image",))),
            child: CustomRoundedPhoto(
              image: "$image",
              radius: 30,
              borderWidth: 0,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawHeaderText(text: "$serviceName",color: ThemeColor.mainGold ,fontSize: 14),
                    CustomRichText(title: "quantity".tr(), subTitle: "$quantity",fontSize: 14,)
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawHeaderText(text: "$serviceName", fontSize: 14),
                    CustomRichText(title: "price".tr(), subTitle: "$price ${"sar".tr()}", fontSize: 14,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _UserNote extends StatelessWidget {
  final String? note;
  const _UserNote({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.11,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DrawSingleText(text: note ?? "there_are_no_notes".tr(), fontSize: 14)
    );
  }
}

