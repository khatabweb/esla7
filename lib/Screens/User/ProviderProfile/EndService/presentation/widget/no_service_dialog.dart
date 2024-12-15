import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NoServicesAlert extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      verticalOffset: 150.0,
      child: CupertinoAlertDialog(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: DrawHeaderText(
              text: "please_select_one_or_more_services_to_complete_the_order"
                  .tr(),
              textAlign: TextAlign.center),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: DrawSingleText(
                text: "back".tr(), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
