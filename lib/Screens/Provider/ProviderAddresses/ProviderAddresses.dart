import '../AddNewAddress/AddNewAddress.dart';
import 'DeleteAddress_alert.dart';
import '../../Widgets/AnimatedWidgets.dart';
import '../../Widgets/Custom_AppBar.dart';
import '../../Widgets/Custom_Button.dart';
import '../../Widgets/Custom_RichText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProviderAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        context: context,
        appBarTitle: "my_addresses".tr(),
        backgroundColor: Colors.white,
      ),
      body: AnimatedWidgets(
        verticalOffset: 150,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, item) {
                    return _ProviderAddress();
                  },
                ),
              ),
            ),
            _AddNewAddressButton(),
          ],
        ),
      ),
    );
  }
}

class _ProviderAddress extends StatelessWidget {
  const _ProviderAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    title: "city".tr(),
                    subTitle: "الرياض",
                  ),
                  CustomRichText(
                    title: "address".tr(),
                    subTitle: "شارع الملك فيصل",
                  ),
                ],
              ),
            ),
          ),
          _CardIcon(
            image: "assets/icons/edit.png",
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        AddNewAddress(appBarTitle: "edit_address".tr()))),
          ),
          _CardIcon(
            image: "assets/icons/delete.png",
            onTap: () => showCupertinoDialog(
                context: context, builder: (_) => RemoveAddressAlert()),
          ),
        ],
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  const _CardIcon({Key? key, this.onTap, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Center(
            child: Image.asset(image!,
                height: 20, width: 20, fit: BoxFit.contain)),
      ),
    );
  }
}

class _AddNewAddressButton extends StatelessWidget {
  const _AddNewAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      rightPadding: 15,
      leftPadding: 15,
      topPadding: 10,
      bottomPadding: 10,
      text: "add_new_address".tr(),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AddNewAddress(appBarTitle: "add_location".tr()))),
    );
  }
}
