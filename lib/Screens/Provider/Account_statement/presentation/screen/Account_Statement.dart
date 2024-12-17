import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../widget/single_account_statement_card.dart';
import '../widget/total_account_statement.dart';

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
            TotalAccountStatement(),
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
                    return SingleAccountStatementCard();
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



