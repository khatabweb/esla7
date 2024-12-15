import '../../../../../Widgets/helper/cache_helper.dart';
import '../../data/cubit/user_notification_cubit.dart';
import '../widget/notification_item.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/CenterMessage.dart';
import '../../../../../Widgets/login_dialog/custom_login_dialog.dart';
import '../../../Custom_Drawer/Custom_Drawer.dart';
import '../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../Widgets/Custom_Background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool? skip;

  void skipCase() {
    setState(() {
      skip =
          CacheHelper.instance!.getData(key: "skip", valueType: ValueType.bool);
    });
    print("skip case NotificationPage ::::::::::: $skip");
  }

  @override
  void initState() {
    context.read<UserNotificationCubit>().getNotification();
    skipCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: customAppBar(
          context: context,
          appBarTitle: "notifications".tr(),
          showDrawerIcon: true,
          onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        drawer: DrawerView(),
        body: skip == true
            ? LoginAlert()
            : BlocBuilder<UserNotificationCubit, UserNotificationState>(
                builder: (context, state) {
                  if (state is UserNotificationLoading) {
                    return CenterLoading();
                  } else if (state is UserNotificationSuccess) {
                    final model = state.userNotificationModel;
                    print("object of model ${model.status}");
                    if (model.notification!.length == 0) {
                      return CenterMessage("no_notification_yet".tr());
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(right: 15, left: 15),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          itemCount: model.notification?.length,
                          itemBuilder: (context, index) {
                            return NotificationItem(
                              titles: context.locale.languageCode == "ar"
                                  ? "${model.notification?[index]?.body}"
                                  : "${model.notification?[index]?.bodyEn}",
                              orderNumber:
                                  model.notification?[index]?.orderId,
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is UserNotificationError) {
                    return CenterMessage(state.error);
                  }
                  return CenterLoading();
                },
              ),
      ),
    );
  }
}
