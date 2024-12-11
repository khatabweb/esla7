import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_Background.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../Widgets/helper/cache_helper.dart';
import '../../data/cubit/chat_cubit.dart';
import '../widgets/message_bubble.dart';
import '../widgets/send_message.dart';

class ChatView extends StatefulWidget {
  final String? date;
  final String? name;
  final int? chatId;
  final int? msgId;
  final bool? isFinished;
  ChatView({this.name, this.date, this.chatId, this.msgId, this.isFinished});
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  GetStorage box = GetStorage();
  Timer? timer;
  final String language = translator.activeLanguageCode;

  @override
  void initState() {
    // _updateMsg();
    Timer.periodic(Duration(seconds: 10), (timer) => getMessages());
    super.initState();
  }

  int? id = 0;

  Future<void> getMessages() async {
    if (CacheHelper.instance!
            .getData(key: "type", valueType: ValueType.string) ==
        'user') {
      id = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);
      print('user id : $id');
    } else {
      id = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);
      ;
      print('owner id : $id');
    }
    // _chatModel = await _chatController.getMessage(widget.chatId);
    context.read<ChatCubit>().getMessage(widget.chatId);

    print(
        "vsdmvkmsdkvlmsdmvlsdkmkmvksmdk;vmsd;klm;ldsmv;ladms;lvmds${widget.chatId}");

    rebuild();
  }

  // ChatController _chatController = ChatController();
  // void _updateMsg()async{
  //  await _chatController.updateMessage(widget.msgId!);
  // }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  // final PreferredSizeWidget? appBar =  HeaderInfo() as PreferredSizeWidget;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            titleSpacing: 0,
            elevation: 0.5,
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor)),
            title: Text(
              widget.name!,
              style: TextStyle(
                fontFamily: "JannaLT-Bold",
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            )),
        body: CustomBackground(child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return CenterLoading();
            } else if (state is ChatSuccess) {
              final _chatModel = context.read<ChatCubit>().chatModel;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.all(10),
                      itemCount: _chatModel.data!.length,
                      itemBuilder: (_, index) {
                        return MessageBubble(
                          image: _chatModel.data![index].file != null
                              ? "${ApiUtl.main_image_url}${_chatModel.data![index].file}"
                              : null,
                          message: _chatModel.data![index].message,
                          date: _chatModel.data![index].createdAt,
                          isMe: _chatModel.data![index].senderId == id,
                        );
                      },
                    ),
                  ),
                  SendMessage(
                    chatId: _chatModel.data![0].conversationId,
                    receiverId: //_chatModel.data[0].receiverId,
                        box.read('id') == _chatModel.data![0].senderId
                            ? _chatModel.data![0].recieverId
                            : _chatModel.data![0].senderId,
                    senderId: box.read('id') != _chatModel.data![0].senderId
                        ? _chatModel.data![0].recieverId
                        : _chatModel.data![0].senderId,
                    afterSendingMessage: () => getMessages(),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("no data found"),
              );
            }
          },
        )),
      ),
    );
  }

  void rebuild() async => this.mounted ? setState(() {}) : null;
}

class _FinishedChatCard extends StatelessWidget {
  const _FinishedChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawSingleText(
            text:
                "لقد انهى مقدم الخدمة طلبك بالفعل وسوف يتم حذف المحادثة تلقائيا بعد 7 أيام",
            color: Theme.of(context).colorScheme.secondary,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 40,
                  rightPadding: 5,
                  leftPadding: 5,
                  text: "order_review".tr(),
                  isFrame: true,
                  onTap: () {},
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 40,
                  rightPadding: 5,
                  leftPadding: 5,
                  text: "create_new_order".tr(),
                  isFrame: true,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
