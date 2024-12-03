import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/ProviderOrders/OrderDetails/OrderDetails_View.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'api/controller.dart';
import 'api/model.dart';

class CurrentProviderOrders extends StatefulWidget {
  const CurrentProviderOrders({Key? key}) : super(key: key);

  @override
  State<CurrentProviderOrders> createState() => _CurrentProviderOrdersState();
}

class _CurrentProviderOrdersState extends State<CurrentProviderOrders> {
  UserCurrentController controller = UserCurrentController();
  OwnerCurrentModel model = OwnerCurrentModel();
  bool isLoading = true;

  void getCurrent() async {
    model = await controller.getCurrent();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CenterLoading()
        : model.order?.length == 0
            ? CenterMessage("no_current_order".tr())
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: model.order?.length,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (_, index) {
                  return AnimatedWidgets(
                    verticalOffset: 150,
                    child: _SingleOrderItem(
                      image: "${ApiUtl.main_image_url}${model.order?[index]?.image}",
                      orderId: model.order?[index]?.id,
                      address: model.order?[index]?.address,
                      date: model.order?[index]?.resDate,
                      state: model.order?[index]?.action,
                    ),
                  );
                },
              );
  }
}


class _SingleOrderItem extends StatelessWidget {
  final String? image;
  final int? orderId;
  final String? address;
  final String? date;
  final String? state;

  const _SingleOrderItem({
    Key? key,
    this.image,
    this.orderId,
    this.address,
    this.date,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderDetailsView(
            orderId: orderId,
            isWaiting: state == "wait" ? true : false,
            isAccepted: state == "accept" ? true : false,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRoundedPhoto(
              image: "$image",
              radius: 30,
              borderWidth: 0,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _OrderNumber(number: orderId),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icons/date.png",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.cover,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(child: DrawSingleText(text: "$date", fontSize: 14, color: Colors.grey[700])),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(child: SizedBox()),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state == "wait" ? _WaitingState() : state == "finished" ? _AcceptedState() : _AcceptedState(),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/location.png",
                          height: 22,
                          width: 22,
                          fit: BoxFit.cover,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 5),
                        Expanded(child: DrawSingleText(text: "$address", color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _OrderNumber extends StatelessWidget {
  final int? number;
  const _OrderNumber({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFdce6f2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawHeaderText(text: "order_number".tr(), fontSize: 12),
          DrawHeaderText(text: "$number", color: ThemeColor.mainGold, fontSize: 12),
        ],
      ),
    );
  }
}



class _WaitingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width / 3.8,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFf8f18c),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DrawHeaderText(
          text: "waiting".tr(),
          fontSize: 12,
        ),
      ),
    );
  }
}



class _AcceptedState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width / 3.8,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFFb0c5e2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DrawHeaderText(
          text: "approved".tr(),
          fontSize: 12,
        ),
      ),
    );
  }
}