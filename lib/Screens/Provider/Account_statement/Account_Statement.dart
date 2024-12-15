import '../../../Theme/color.dart';
import '../../Widgets/AnimatedWidgets.dart';
import '../../Widgets/Custom_AppBar.dart';
import '../../Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AccountStatement extends StatelessWidget {
  AccountStatement({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        context: context,
        appBarTitle: "account_statement".tr(),
        backgroundColor: Colors.white,
      ),
      body: AnimatedWidgets(
        verticalOffset: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TotalAccountStatement(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: DrawHeaderText(text: "details".tr(), fontSize: 16),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, item) {
                    return _SingleAccountStatementCard();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalAccountStatement extends StatelessWidget {
  const _TotalAccountStatement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawHeaderText(
              text: "total_statement_of_account".tr(),
              color: Colors.black,
              fontSize: 16),
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawHeaderText(text: "1000", color: Colors.white, fontSize: 16),
                DrawHeaderText(text: "sar".tr(), color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleAccountStatementCard extends StatelessWidget {
  const _SingleAccountStatementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            spreadRadius: 0.2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(
              "assets/icons/time.png",
              width: 20,
              height: 20,
              fit: BoxFit.cover,
              color: ThemeColor.mainGold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              // color: Colors.greenAccent,
              // margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawHeaderText(
                    text: "2021/9/10",
                    color: ThemeColor.mainGold,
                    fontSize: 14,
                  ),
                  DrawSingleText(
                    text:
                        "هذا النص هو مثال لنص يمكن ان يستبدل في نفس المساحة لقد تم توليد النص",
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ),
          DrawHeaderText(
            text: "120 ${"sar".tr()}",
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
