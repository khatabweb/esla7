import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controller.dart';
import 'customTextFeild.dart';


TextEditingController _messageController = TextEditingController();

class SendMessage extends StatefulWidget {
  final Function? afterSendingMessage;
  final int? chatId;
  final int? senderId;
  final int? receiverId;
  SendMessage({this.afterSendingMessage, this.chatId,this.receiverId, this.senderId});

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  XFile? image;
  ChatController _chatController = ChatController();

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("receiver id : ${widget.receiverId}");
    print("send message sender id : ${widget.senderId}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.camera_alt,color: Colors.white,),
              onPressed: ()async{
                final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                image = XFile(pickedFile!.path);
                setState(() {
                  _isLoading = true;
                });
                if(image != null)
                await _chatController.sendMessage(
                  file: image,
                  conversationId: widget.chatId,
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                );
                setState((){
                  _isLoading = false;
                });
                widget.afterSendingMessage!();
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomChatTextField(
              hint: "message",
              controller: _messageController,
            ),
          ),
          SizedBox(width: 10),
          _isLoading
              ? CenterLoading()
              : Container(
                  padding: EdgeInsets.all(13),
                  child: InkWell(
                    child: Icon(Icons.send, color: Colors.white),
                    onTap: () async {
                      if (_messageController.text != null && _messageController.text.isNotEmpty) {
                        setState(() => _isLoading = true);
                        await _chatController.sendMessage(
                          message: _messageController.text,
                          conversationId: widget.chatId,
                          senderId: widget.senderId,
                          receiverId: widget.receiverId,
                        );
                        widget.afterSendingMessage!();
                        setState(() => _isLoading = false);
                        _messageController.clear();
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}
