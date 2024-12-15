import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_Background.dart';
import '../../../Widgets/helper/cache_helper.dart';
import '../../../Widgets/login_dialog/custom_login_dialog.dart';
import '../Custom_Drawer/Custom_Drawer.dart';
import 'CurrentOrders/presentation/screen/CurrentOrders.dart';
import 'FinishedOrders/FinishedOrders.dart';

class UserOrdersView extends StatefulWidget {
  @override
  _UserOrdersViewState createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isChecked = true;
  bool? skip;

  void shared() async {
    setState(() {
      skip =
          CacheHelper.instance!.getData(key: "skip", valueType: ValueType.bool);
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    shared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: customAppBar(
        context: context,
        showDrawerIcon: true,
        centerTitle: false,
        appBarTitle: "orders".tr(),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        onPressedDrawer: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      drawer: DrawerView(),
      body: CustomBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedWidgets(
              verticalOffset: -50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CustomTap(
                    text: "current_orders".tr(),
                    textColor: _isChecked
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    color: _isChecked
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    onTap: () {
                      print("الحالية");
                      setState(() {
                        _isChecked = true;
                      });
                    },
                  ),
                  _CustomTap(
                    text: "finished_orders".tr(),
                    textColor: !_isChecked
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    color: !_isChecked
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    onTap: () {
                      print("المنتهية");
                      setState(() {
                        _isChecked = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: skip == true
                  ? LoginAlert()
                  : _isChecked
                      ? CurrentOrders()
                      : FinishedOrders(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTap extends StatelessWidget {
  final String? text;
  final Color? color, textColor;
  final void Function()? onTap;
  const _CustomTap({this.text, this.color, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2.3,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            text ?? "",
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontFamily: "JannaLT-Bold",
            ),
          ),
        ),
      ),
    );
  }
}
