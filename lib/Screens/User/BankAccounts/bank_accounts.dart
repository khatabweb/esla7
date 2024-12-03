import 'package:esla7/Screens/User/CheckOut/check_out_view.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'API/controller.dart';
import 'API/model.dart';

class BankAccounts extends StatefulWidget {
  final String? ownerName;
  final int? totalPrice;
  const BankAccounts(this.ownerName, this.totalPrice);

  @override
  State<BankAccounts> createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  String language = translator.activeLanguageCode;
  BankAccountsController _controller = BankAccountsController();
  BankAccountsModel _model = BankAccountsModel();
  bool isLoading = true;

  getBanks() async {
    _model = await _controller.getBanks();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    getBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarTitle: "bank_accounts".tr(),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        body: CustomBackground(
          child: AnimatedWidgets(
            verticalOffset: 150,
            child: isLoading ? CenterLoading() : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _model.banksList?.length,
                    itemBuilder: (context, index) {
                      var item = _model.banksList?[index];
                      return _SingleAccountCard(
                        image: item?.imagePath,
                        ownerName: item?.ownerName,
                        bankName: item?.bankName,
                        ibanNumber: item?.number,
                      );
                    },
                  ),
                ),

                CustomButton(
                  text: "pay".tr(),
                  rightPadding: 15,
                  leftPadding: 15,
                  bottomPadding: 15,
                  width: MediaQuery.of(context).size.width,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckOutView(widget.ownerName, widget.totalPrice))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SingleAccountCard extends StatelessWidget {
  final String? image;
  final String? ownerName;
  final String? bankName;
  final String? ibanNumber;
  const _SingleAccountCard({Key? key, this.image, this.ownerName, this.bankName, this.ibanNumber,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 6.5,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: height,
            width: width / 4.5,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage("$image"),
                fit: BoxFit.cover
              )
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawSingleText(text: "$ownerName", fontSize: 13),
                  DrawHeaderText(text: "$bankName", fontSize: 16),
                  DrawHeaderText(text: "$ibanNumber", fontSize: 13),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
