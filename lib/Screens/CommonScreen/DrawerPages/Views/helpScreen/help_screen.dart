import '../../../../../core/Theme/color.dart';
import '../../controllers/common_controller.dart';
import '../../models/helping_model.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpView extends StatefulWidget {
  final bool isUser;

  const HelpView({super.key, required this.isUser});
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  
  HelpingController _helpingController = HelpingController();
  HelpingModel _helpingModel = HelpingModel();
  bool _isLoading = true;

  void _getHelp() async {
    _helpingModel = await _helpingController.getHelp(isUser: widget.isUser);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getHelp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "help".tr(),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: _isLoading
          ? CenterLoading()
          : AnimatedWidgets(
              verticalOffset: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelpVideo(
                      url: _helpingModel
                          .vedioLink), //"https://www.youtube.com/watch?v=gY7592DsFdw"
                  _SupportNumber(number: _helpingModel.supportNumber),
                  _CommonQuestions(
                    questions: context.locale.languageCode == "ar"
                        ? _helpingModel.questionAr
                        : _helpingModel.questionEn,
                  ),
                ],
              ),
            ),
    );
  }
}

class HelpVideo extends StatefulWidget {
  HelpVideo({Key? key, this.url}) : super(key: key);
  final url;

  @override
  _HelpVideoState createState() => _HelpVideoState();
}

class _HelpVideoState extends State<HelpVideo> {
  YoutubePlayerController? _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url) as String,
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
          isLive: false,
        ));
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller as YoutubePlayerController,
      ),
      builder: (context, player) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(15),
          ),
          child: player,
        );
      },
    );
  }
}

class _SupportNumber extends StatelessWidget {
  final String? number;
  const _SupportNumber({Key? key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawHeaderText(
              text: "technical_support_number".tr(),
              color: ThemeColor.mainGold),
          DrawHeaderText(
              text: "$number", fontSize: 14, textDirection: TextDirection.ltr),
        ],
      ),
    );
  }
}

class _CommonQuestions extends StatelessWidget {
  final String? questions;
  const _CommonQuestions({Key? key, this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawHeaderText(
              text: "common_questions".tr(), color: ThemeColor.mainGold),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DrawSingleText(text: "$questions", fontSize: 14),
          )
        ],
      ),
    );
  }
}
