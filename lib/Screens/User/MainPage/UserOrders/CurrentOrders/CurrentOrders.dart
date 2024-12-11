import 'data/cubit/user_current_cubit.dart';
import '../OrderDetails/OrderDetails_View.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/CenterMessage.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../../../API/api_utility.dart';
import '../../../../../../../Theme/color.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  final String lang = translator.activeLanguageCode;
  // UserCurrentController controller = UserCurrentController();
  // UserCurrentModel model = UserCurrentModel();
  // bool isLoading = true;

  // void getCurrent() async {
  //   model = await controller.getCurrent();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    context.read<UserCurrentCubit>().getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCurrentCubit, UserCurrentState>(
        builder: (context, state) {
      if (state is UserCurrentLoading) {
        return CenterLoading();
      } else if (state is UserCurrentSuccess) {
        final model = state.model;
        if (model.order?.length == 0) {
          return CenterMessage("no_current_order".tr());
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: model.order?.length,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (_, index) {
              var item = model.order?[index];
              print("orderrrrrrrrrr Length ::::::: ${model.order?.length}");
              return AnimatedWidgets(
                verticalOffset: 150,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailsView(
                          orderId: item?.id,
                          isWaiting: item?.action == "wait" ? true : false,
                          isAccepted: item?.action == "accept" ? true : false,
                        ),
                      ),
                    );
                  },
                  child: _SingleOrder(
                    image: "${ApiUtl.main_image_url}${item?.image}",
                    orderId: item?.id,
                    address: "${item?.address}",
                    date: "${item?.resDate}",
                    state: "${item?.action}",
                  ),
                ),
              );
            },
          );
        }
      } else if (state is UserCurrentError) {
        return CenterMessage(state.error);
      } else {
        return CenterMessage("error_message".tr());
      }
    });
  }
}

class _SingleOrder extends StatelessWidget {
  final String? image;
  final int? orderId;
  final String? address;
  final String? date;
  final String? state;

  const _SingleOrder({
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
                          state == "accept"
                              ? _AcceptedState()
                              : _WaitingState(),
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
          DrawHeaderText(
              text: "$number", color: ThemeColor.mainGold, fontSize: 12),
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
