import '../../../../../core/API/api_utility.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/Custom_SnackBar.dart';
import '../../../../../core/Theme/color.dart';
import '../../../../CommonScreen/DrawerPages/Views/Complaints_and_suggestions/presentation/screen/Complaints_and_suggestions.dart';
// import 'OrderItemCard.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/Custom_AppBar.dart';
import '../../../../Widgets/Custom_Background.dart';
import '../../../../Widgets/Custom_Button.dart';
import '../../../../Widgets/Custom_DrawText.dart';
import '../../../../Widgets/Custom_RichText.dart';
import '../../../../Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'DialogComponent/acceptOrder_dialog.dart';
// import 'DialogComponent/endingOrder_dialog.dart';
import 'DialogComponent/rejected_dialog.dart';
import 'data/bloc/cubit.dart';
import 'buttons_bloc/data/accept/cubit.dart';
import 'buttons_bloc/data/accept/state.dart';
// import 'buttons_bloc/data/refuse/cubit.dart';
// import 'buttons_bloc/data/refuse/state.dart';

class OrderDetailsView extends StatefulWidget {
  final int? orderId;
  final bool? isWaiting, isAccepted, isCompleted;

  OrderDetailsView({
    this.isWaiting,
    this.isAccepted,
    this.isCompleted,
    this.orderId,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool isLoading = true;

  Future orderDetails() async {
    print("in Service ..........................");
    final cubit = OwnerOrderDetailsCubit.get(context);
    cubit.orderId = widget.orderId;
    print("order id ::::::::::::::::::::::: ${cubit.orderId}");
    return cubit.orderDetails();
  }

  @override
  void initState() {
    orderDetails().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = OwnerOrderDetailsCubit.get(context);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "${"order_num".tr()} ${widget.orderId}",
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: CustomBackground(
        child: isLoading
            ? CenterLoading()
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: AnimatedWidgets(
                  verticalOffset: 150,
                  child: Column(
                    children: [
                      //========================= user details ============================
                      _UserDetails(
                        image:
                            "${ApiUtl.main_image_url}${cubit.model.userImage}",
                        userName: "${cubit.model.userName}",
                        orderId: cubit.model.orderNumber,
                      ),
    
                      //========================= order details ============================
                      // OrderItemCard(
                      //   image: "${ApiUtl.main_image_url}${cubit.model.image}",
                      //   serviceName: language == "ar" ? "${cubit.model.servicesNameAr}" : "${cubit.model.servicesNameEn}",
                      //   quantity: cubit.model.quantity,
                      //   price: cubit.model.price,
                      //   note: (cubit.model.notes == "null" || cubit.model.notes == null)
                      //       ? "there_are_no_note".tr()
                      //       : cubit.model.notes,
                      // ),
    
                      //========================= details ============================
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRichText(
                                title: "total_order_price".tr(),
                                subTitle:
                                    "${cubit.model.totalPrice} ${"sar".tr()}"),
                            CustomRichText(
                                title: "address".tr(),
                                subTitle: "${cubit.model.address}"),
                            CustomRichText(
                                title: "date".tr(),
                                subTitle: "${cubit.model.resDate}"),
                            CustomRichText(
                                title: "time".tr(),
                                subTitle: "${cubit.model.resTime}"),
                          ],
                        ),
                      ),
    
                      //========================= Buttons ============================
                      widget.isWaiting == true
                          ? _WaitingButton(orderId: widget.orderId)
                          // : widget.isAccepted == true
                          //     ? _EndingButton(orderId: widget.orderId)
                          : widget.isCompleted == true
                              ? _CompletedButton()
                              : SizedBox(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  // final bool? isPayed;
  // final bool? isAccepted;
  final String? image;
  final String? userName;
  final int? orderId;

  const _UserDetails({
    Key? key,
    // this.isPayed,
    // this.isAccepted,
    this.image,
    this.userName,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomRoundedPhoto(
                image: "$image",
                radius: 35,
                borderWidth: 0,
              ),
              SizedBox(width: 10),
              DrawHeaderText(
                text: "$userName",
                color: ThemeColor.mainGold,
                fontSize: 14,
              ),
            ],
          ),
          _OrderNumber(number: orderId),
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

//======================================================== buttons Caseeeeees ====================================================
class _WaitingButton extends StatelessWidget {
  final int? orderId;
  const _WaitingButton({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final acceptCubit = AcceptCubit.get(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<AcceptCubit, AcceptState>(
          listener: (_, state) {
            if (state is AcceptErrorState) {
              customSnackBar(_, state.error);
            } else if (state is AcceptSuccessState) {
              Navigator.pop(context);
              showCupertinoDialog(
                  context: context,
                  builder: (_) {
                    return AcceptOrderDialog();
                  });
              print("========== done ==========");
            }
          },
          builder: (context, state) {
            return state is AcceptLoadingState
                ? CenterLoading()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: "accept".tr(),
                        fontSize: 12,
                        width: MediaQuery.of(context).size.width / 2.3,
                        onTap: () => acceptCubit.acceptOrder(orderId),
                      ),
                      CustomButton(
                        text: "reject".tr(),
                        fontSize: 12,
                        isFrame: true,
                        width: MediaQuery.of(context).size.width / 2.3,
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (_) {
                                return RejectedAlert(orderId: orderId);
                              });
                        },
                      ),
                    ],
                  );
          },
        ));
  }
}

// class _EndingButton extends StatelessWidget {
//   final int? orderId;
//   const _EndingButton({Key? key, this.orderId}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final refuseCubit = RefuseCubit.get(context);
//     return BlocConsumer<RefuseCubit, RefuseState>(
//       listener: (_, state) {
//         if (state is RefuseErrorState) {
//           customSnackBar(_, state.error);
//         } else if (state is RefuseSuccessState) {
//           Navigator.pop(context);
//           showCupertinoDialog(
//               context: context,
//               builder: (_) {
//                 return EndingOrderDialog();
//               });
//           print("========== done ==========");
//         }
//       },
//       builder: (context, state) {
//         return state is RefuseLoadingState
//             ? CenterLoading()
//             : CustomButton(
//                 text: "ending".tr(),
//                 leftPadding: 15,
//                 rightPadding: 15,
//                 width: MediaQuery.of(context).size.width,
//                 onTap: () => refuseCubit.refuseOrder(orderId),
//               );
//       },
//     );
//   }
// }

class _CompletedButton extends StatelessWidget {
  const _CompletedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "report".tr(),
      leftPadding: 15,
      rightPadding: 15,
      width: MediaQuery.of(context).size.width,
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ComplaintsAndSuggestion())),
    );
  }
}
