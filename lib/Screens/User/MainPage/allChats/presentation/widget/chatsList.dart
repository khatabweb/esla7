// import 'package:esla7/Screens/Widgets/helper/cache_helper.dart';

import 'chatCard.dart';
import '../../../../../Widgets/CenterMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../data/model/AllChatsModel.dart';

class AllChatsList extends StatelessWidget {
  final AllChatsModel allChatsModel;

  const AllChatsList({Key? key, required this.allChatsModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return allChatsModel.data?.length == 0
        ? CenterMessage("there_are_no_chats".tr())
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => ChatsCard(
                name: allChatsModel.data![index].sender != null
                    ? allChatsModel.data![index].sender!.id != box.read("id")
                        ? allChatsModel.data![index].sender!.name
                        // : "nothing"
                        : allChatsModel.data![index].receiverOwner?.name
                    : allChatsModel.data![index].senderOwner?.id !=
                            box.read("id")
                        ? allChatsModel.data![index].senderOwner?.name
                        : allChatsModel.data![index].receiver!.name,
                image: allChatsModel.data![index].sender != null
                    ? allChatsModel.data![index].sender!.id != box.read("id")
                        ? allChatsModel.data![index].sender!.image
                        : allChatsModel.data![index].receiverOwner?.image
                    : allChatsModel.data![index].senderOwner?.id !=
                            box.read("id")
                        ? allChatsModel.data![index].senderOwner?.image
                        : allChatsModel.data![index].receiver!.image,
                rate: allChatsModel.data![index].sender != null
                    ? allChatsModel.data![index].sender!.id != box.read("id")
                        ? allChatsModel.data![index].sender!.rate
                        : allChatsModel.data![index].receiverOwner?.rate
                    : allChatsModel.data![index].senderOwner?.id !=
                            box.read("id")
                        ? allChatsModel.data![index].senderOwner?.rate
                        : allChatsModel.data![index].receiver!.rate,
                chatId: allChatsModel.data![index].id,
                // view: allChatsModel!.data![index].lastchat!.view,
                msgId: allChatsModel.data![index].lastchat!.id,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (ctx, ind) => SizedBox(height: 0),
              itemCount: allChatsModel.data?.length ?? 0,
            ),
          );
  }
}
