import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/presentation/widget/accept.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/presentation/widget/order_number.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/presentation/widget/wating.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';

class SingleOrder extends StatelessWidget {
  final String? image;
  final int? orderId;
  final String? address;
  final String? date;
  final String? state;

  const SingleOrder({
    Key? key,
    this.image,
    this.orderId,
    this.address,
    this.date,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            OrderNumber(number: orderId),
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
                                Expanded(
                                    child: DrawSingleText(
                                        text: "$date",
                                        fontSize: 14,
                                        color: Colors.grey[700])),
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
                          state == "accept" ? AcceptedState() : WaitingState(),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 5),
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
                      Expanded(
                          child: DrawSingleText(
                              text: "$address", color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
