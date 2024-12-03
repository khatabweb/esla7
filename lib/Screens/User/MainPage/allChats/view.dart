import 'package:esla7/Screens/User/MainPage/Custom_Drawer/Custom_Drawer.dart';
import 'package:esla7/Screens/User/MainPage/allChats/chatsList.dart';
import 'package:esla7/Screens/User/MainPage/allChats/controller/controller.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/login_dialog/custom_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/AllChatsModel.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AllChatsModel _allChatsModel =AllChatsModel();
  AllChatsController _allChatsController =AllChatsController();
  bool loading= true;
  bool? skip;

  void _getAllChats()async{
    _allChatsModel = await _allChatsController.getAllChats();
    setState(() {
      loading = false;
    });
  }

  void skipCase() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      skip = _pref.getBool("skip");
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    _getAllChats();
    skipCase();
    super.initState();
  }

  final String language = translator.activeLanguageCode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: customAppBar(
          context: context,
          appBarTitle: "chats".tr(),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
          showDrawerIcon: true,
          onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        drawer: DrawerView(),
        body: CustomBackground(
          child: AnimatedWidgets(
            verticalOffset: 150,
            child: skip == true ? LoginAlert() : loading? CenterLoading() : AllChatsList(
              allChatsModel: _allChatsModel,
            ),
          ),
        ),
      ),
    );
  }
}
