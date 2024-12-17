import '../../../../../../core/API/api_utility.dart';
import '../../../chat/presentation/screen/view.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChatsCard extends StatelessWidget {
  final String? name;
  final String? image;
  final String? serviceName;
  final int? orderNumber;
  final int? chatId;
  final int? msgId;
  final int? rate;
  final int? view;
  final String? date;

  ChatsCard(
      {Key? key,
      this.name,
      this.image,
      this.chatId,
      this.date,
      this.rate,
      this.view,
      this.msgId,
      this.serviceName,
      this.orderNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatView(
            date: date,
            name: name,
            chatId: chatId,
            msgId: msgId,
            isFinished: false,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // height: height / 8,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CustomRoundedPhoto(
                      image: "${ApiUtl.main_image_url}$image",
                      radius: 35,
                      borderWidth: 0,
                    ),
                    view == 0
                        ? Positioned(
                            bottom: 3,
                            left:
                                context.locale.languageCode == "ar" ? 3 : null,
                            right:
                                context.locale.languageCode == "ar" ? null : 3,
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 15,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawHeaderText(text: "$name"),
                    // Container(
                    //   width: MediaQuery.of(context).size.width / 3.5,
                    //   child: DrawSingleText(
                    //     text: "$serviceName",
                    //     color: Theme.of(context).colorScheme.secondary,
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     CustomPopOver(
            //       child: Container(
            //         width: 20,
            //         color: Colors.transparent,
            //         alignment: language == "ar" ? Alignment.centerLeft : Alignment.centerRight,
            //         child: Image.asset(
            //           "assets/icons/more.png",
            //           color: Theme.of(context).colorScheme.secondary,
            //           height: 22,
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //       itemList: [
            //         TextButton(onPressed: (){}, child: DrawSingleText(text: "view_order".tr(),)),
            //         TextButton(onPressed: (){}, child: DrawSingleText(text: "calling_provider".tr(),)),
            //         TextButton(onPressed: (){}, child: DrawSingleText(text: "delete_chat".tr(),)),
            //       ],
            //     ),
            //     // SizedBox(height: 10),
            //     // Row(
            //     //   children: [
            //     //     DrawSingleText(text: "order_number".tr(), fontSize: 12),
            //     //     DrawHeaderText(text: "$orderNumber", color: ThemeColor.mainGold, fontSize: 12),
            //     //   ],
            //     // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
