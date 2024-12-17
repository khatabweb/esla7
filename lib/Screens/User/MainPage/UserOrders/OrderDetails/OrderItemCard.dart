import '../../../../../core/Theme/color.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_PhotoScreen.dart';
import '../../../../Widgets/Custom_RichText.dart';
import '../../../../Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class OrderItemCard extends StatelessWidget {
  final String? image;
  final String? subService;
  final String? quantity;
  final String? serviceName;
  final String? price;
  final String? desc;
  final String? note;

  const OrderItemCard({
    Key? key,
    this.image,
    this.subService,
    this.quantity,
    this.serviceName,
    this.price,
    this.desc,
    this.note,
  }) : super(key: key);


  // String language = translator.activeLanguageCode;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 3.5,
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
            subService: subService,
            quantity: quantity,
            serviceName: serviceName,
            price: price,
            desc: desc,
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
  final String? subService;
  final String? quantity;
  final String? serviceName;
  final String? price;
  final String? desc;

  const _OrderItemDetails({
    Key? key,
    this.image,
    this.subService,
    this.quantity,
    this.serviceName,
    this.price,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 6.3,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
              radius: 35,
              borderWidth: 0,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawHeaderText(text: "$subService",color: ThemeColor.mainGold ,fontSize: 13),
                        SizedBox(height: 2),
                        CustomRichText(title: "quantity".tr(), subTitle: "$quantity",)
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // DrawHeaderText(text: "$serviceName", fontSize: 14),
                        CustomRichText(title: "price".tr(), subTitle: "$price ${"sar".tr()}", fontSize: 13,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2),
                DrawSingleText(
                  text: "$desc",
                  fontSize: 12,
                  textHeight: 1,
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

