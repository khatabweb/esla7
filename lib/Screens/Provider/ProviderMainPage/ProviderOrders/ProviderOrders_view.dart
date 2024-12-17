import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_Background.dart';
import '../ProviderDrawer/ProviderDrawer.dart';
import 'CurrentOrders/CurrentOrders.dart';
import 'FinishedOrders/FinishedOrders.dart';

class ProviderOrdersView extends StatefulWidget {
  @override
  _ProviderOrdersViewState createState() => _ProviderOrdersViewState();
}

class _ProviderOrdersViewState extends State<ProviderOrdersView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isChecked = true;

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
      drawer: ProviderDrawerView(),
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
              child: _isChecked
                  ? CurrentProviderOrders()
                  : FinishedProviderOrders(),
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
