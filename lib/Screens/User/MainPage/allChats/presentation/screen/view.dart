import '../../../../../Widgets/helper/cach_helper.dart';

import '../../../Custom_Drawer/Custom_Drawer.dart';
import '../widget/chatsList.dart';
import '../../data/cubit/allchats_cubit.dart';
import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../Widgets/Custom_Background.dart';
import '../../../../../Widgets/login_dialog/custom_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? skip;

  void skipCase() {
    setState(() {
      skip =
          CacheHelper.instance!.getData(key: "skip", valueType: ValueType.bool);
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    // _getAllChats();
    context.read<AllChatsCubit>().getAllChats();
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
            child: skip == true
                ? LoginAlert()
                : BlocBuilder<AllChatsCubit, AllChatsState>(
                    builder: (context, state) {
                      if (state is AllChatsLoading) {
                        return CenterLoading();
                      } else if (state is AllChatsSuccess) {
                        final _allChatsModel = state.allChatsModel;
                        return AllChatsList(
                          allChatsModel: _allChatsModel,
                        );
                      } else if (state is AllChatsError) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
