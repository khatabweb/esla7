import '../../core/local_storge/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../User/Search/presentation/screen/Search_view.dart';
// import '../../core/helper/cache_helper.dart';
import 'login_dialog/custom_login_dialog.dart';

PreferredSizeWidget? customAppBar({
  required BuildContext context,
  required String appBarTitle,
  final bool showDrawerIcon = false,
  final bool showSearchIcon = false,
  final bool centerTitle = false,
  final bool showBackButton = true,
  final double? elevation,
  final double? fontSize,
  final Color? backgroundColor,
  void Function()? onPressedDrawer,
  Widget? otherIconWidget,
  void Function()? onTapOtherIcon,
  void Function()? onTapSearchIcon,
}) {
  //
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: elevation ?? 0,
    titleSpacing: 0,
    leadingWidth: 50,
    centerTitle: centerTitle,
    leading: showDrawerIcon == true
        ? drawerIcon(
            context: context,
            onPressed: onPressedDrawer,
            color: Theme.of(context).primaryColor,
          )
        : showBackButton == false
            ? SizedBox()
            : InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(
                      right: 15,
                      left: context.locale.languageCode == "ar" ? 0 : 15,
                      top: 15,
                      bottom: 15),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: backgroundColor == Theme.of(context).primaryColor
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
    title: Text(
      appBarTitle,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: fontSize ?? 18,
        color: backgroundColor == Theme.of(context).primaryColor
            ? Colors.white
            : Theme.of(context).primaryColor,
        fontFamily: 'JannaLT-Bold',
      ),
    ),
    actions: [
      showSearchIcon == true
          ? InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Image.asset(
                  "assets/icons/search.png",
                  color: Theme.of(context).primaryColor,
                  fit: BoxFit.fill,
                ),
              ),
              onTap: () async {
                CacheHelper.instance!
                            .getData(key: "skip", valueType: ValueType.bool) ==
                        true
                    ? showCupertinoDialog(
                        context: context, builder: (_) => LoginAlert())
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchView()));
              },
            )
          : Container(),
      otherIconWidget ?? SizedBox(),
    ],
  );
}

Widget drawerIcon({
  BuildContext? context,
  void Function()? onPressed,
  Color? color,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 10,
      height: 20,
      margin: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
      child: Center(
        child: Image.asset(
          context!.locale.languageCode == "ar"
              ? "assets/icons/menu.png"
              : "assets/icons/menuen.png",
          color: Theme.of(context).primaryColor,
          fit: BoxFit.cover,
          height: 15,
          width: 30,
        ),
      ),
    ),
  );
}
