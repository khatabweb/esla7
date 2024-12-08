import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool? isMe;
  final String? message;
  final String? date;
  final String? image;
  MessageBubble({this.isMe, this.message, this.date, this.image});
  @override
  Widget build(BuildContext context) {
    final width = 100.0;
    //sizeFromWidth(context, 5);
    return Container(
      margin: EdgeInsets.only(
        left: isMe == true ? width : 0.0,
        right: isMe == false ? width : 0.0,
        bottom: 10,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (image == null)
              ? SelectableText(
                  "$message",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    // return showDialog(context: context, builder: (ctx) =>
                    //     StatefulBuilder(
                    //         builder: (BuildContext context,StateSetter setState) {
                    //           return AlertDialog(
                    //               backgroundColor: Colors.transparent,
                    //               content: Container(
                    //                 height: height/2,
                    //                 width: _width/2,
                    //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    //                     image: DecorationImage(image: NetworkImage("https://jeet.sa.com/public/${image}"),fit: BoxFit.fill)),
                    //               ));
                    //         }));
                  },
                  child: Image.network("$image")),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              date ?? "",
              style: TextStyle(
                fontWeight: isMe == true ? FontWeight.w200 : FontWeight.w400,
                color: Colors.black,
                fontSize: 12,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: isMe == true ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
