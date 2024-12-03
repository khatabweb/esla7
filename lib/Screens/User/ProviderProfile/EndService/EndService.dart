import 'package:esla7/Screens/User/ProviderProfile/EndService/model/model.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/User/Cart/cart_page.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RichText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/cubit.dart';
import 'no_service_dialog.dart';

class EndService extends StatefulWidget {
  final int? ownerId;
  final int? serviceId;
  final String? appBarTitle;
  const EndService({Key? key, this.appBarTitle, this.serviceId, this.ownerId}) : super(key: key);

  @override
  _EndServiceState createState() => _EndServiceState();
}

class _EndServiceState extends State<EndService> {
  final String language = translator.activeLanguageCode;
  bool isSelected = false;
  bool isLoading = true;

  Future userEndService() {
    final cubit = UserEndListCubit.get(context);
    return cubit.userEndService(widget.ownerId, widget.serviceId);
  }

  @override
  void initState() {
    userEndService().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = UserEndListCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(context: context, appBarTitle: "${widget.appBarTitle}", backgroundColor: Colors.white),
          body: isLoading
              ? CenterLoading()
              : cubit.endListModel.services?.length == 0
                  ? CenterMessage("there_are_no_services_now_for_this_sub".tr())
                  : AnimatedWidgets(
                      verticalOffset: 150,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cubit.endListModel.services?.length,
                              itemBuilder: (context, index) {
                                var item = cubit.endListModel.services?[index];
                                return _SubServiceCard(
                                  serviceName: language == "ar"
                                      ? "${item?.nameAr}"
                                      : "${item?.nameEn}",
                                  price: item?.price,
                                  desc: "${item?.descreption}",
                                  // isChecked: checked[index],
                                  onTap: (){
                                    setState(() {
                                      // checked[index] = !checked[index];
                                    });
                                  },
                                  ownerId: widget.ownerId,
                                  serviceId: widget.serviceId,
                                );
                              },
                            ),
                          ),
                          _AddToCartButton(
                            onTap: () {
                              cubit.cartItemList.length == 0
                                  ? showCupertinoDialog(context: context, builder: (_) => NoServicesAlert())
                                  : Navigator.push(context,MaterialPageRoute(builder: (_) => CartPage()));
                            },
                          ),
                        ],
                      ),
                    )
      ),
    );
  }
}


class _SubServiceCard extends StatelessWidget {
  final String? serviceName;
  final int? price;
  final String? desc;
  final int? ownerId;
  final int? serviceId;
  final bool? isChecked;
  final void Function()? onTap;

  const _SubServiceCard({Key? key,this.onTap, this.serviceName, this.price, this.desc, this.isChecked, this.ownerId, this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(title: "service_name".tr(), subTitle: "$serviceName", fontSize: 13),
                    CustomRichText(title: "price".tr(), subTitle: "$price ${"sar".tr()}", fontSize: 13),
                    CustomRichText(title: "service_desc".tr(), subTitle: "$desc", fontSize: 13),
                  ],
                ),
              ),
            ),
            SubServiceCheckBox(serviceId: serviceId,ownerId: ownerId,desc: desc,price: price,serviceName: serviceName,),

          ],
        ),
      ),
    );
  }
}


class _AddToCartButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _AddToCartButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      verticalOffset: 150,
      child: CustomButton(
        leftPadding: 15,
        rightPadding: 15,
        bottomPadding: 15,
        topPadding: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/cart.png", color: Colors.white, width: 20, height: 20, fit: BoxFit.contain),
            SizedBox(width: 10),
            DrawHeaderText(text: "add_service".tr(), color: Colors.white,fontSize: 15),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class SubServiceCheckBox extends StatefulWidget {
  final String? serviceName;
  final int? price;
  final String? desc;
  final int? ownerId;
  final int? serviceId;
  final bool? isSelected;
  SubServiceCheckBox({Key? key, this.isSelected, this.serviceName, this.price, this.desc, this.ownerId, this.serviceId}) : super(key: key);


  @override
  _SubServiceCheckBoxState createState() => _SubServiceCheckBoxState();
}

class _SubServiceCheckBoxState extends State<SubServiceCheckBox> {
  bool isChecked = false;


  @override
  void initState() {
    isChecked = widget.isSelected ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = UserEndListCubit.get(context);
    return Checkbox(
      value: isChecked,
      onChanged: (val) {
        setState(() {
          isChecked = val as bool;
        });

        if(val==true) {
          cubit.cartItemList.add(CartItemModel(name: widget.serviceName,
            serviceDesc: widget.desc,
            price: widget.price,
            serviceId: widget.serviceId,
            ownerId: widget.ownerId,));
          print(cubit.cartItemList);
        }else{
          cubit.cartItemList.removeAt(cubit.cartItemList.indexOf(CartItemModel(name: widget.serviceName,
            serviceDesc: widget.desc,
            price: widget.price,
            serviceId: widget.serviceId,
            ownerId: widget.ownerId,)));
          print(cubit.cartItemList);
        }
      },
      activeColor: ThemeColor.mainGold,
      side: BorderSide(
        color: ThemeColor.mainGold,
        width: 1,
      ),
      splashRadius: 25,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
