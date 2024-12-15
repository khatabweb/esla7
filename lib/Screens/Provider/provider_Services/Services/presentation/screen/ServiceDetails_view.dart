import '../../data/bloc/endList/state.dart';
import '../../data/bloc/subList/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/endList/cubit.dart';
import '../../data/bloc/subList/cubit.dart';
import '../../../../../Widgets/AnimatedWidgets.dart';
import '../../../../../Widgets/CenterLoading.dart';
import '../../../../../Widgets/CenterMessage.dart';
import '../../../../../Widgets/Custom_AppBar.dart';
import '../../../../../Widgets/Custom_Background.dart';
import '../../../../../Widgets/Custom_Button.dart';
import '../../../../../Widgets/Custom_DrawText.dart';
import '../../../../../Widgets/Custom_RichText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../Add_Service/AddService/presentation/AddService_dialog.dart';
import '../../../DialogsWidgets/DeleteService_alert.dart';

class ServiceDetails extends StatefulWidget {
  final int? mainServiceId;
  final String? mainServiceName;
  ServiceDetails({Key? key, this.mainServiceId, this.mainServiceName})
      : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  // bool isLoading = true;

  @override
  void initState() {
    context.read<SubServiceListCubit>().subService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final subCubit = SubServiceListCubit.get(context);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "${widget.mainServiceName}",
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: CustomBackground(
        child: AnimatedWidgets(
          verticalOffset: 150,
          child: Column(
            children: [
              Expanded(child:
                  BlocBuilder<SubServiceListCubit, SubServiceListState>(
                      builder: (context, state) {
                if (state is SubServiceListLoadingState) {
                  return CenterLoading();
                } else if (state is SubServiceListSuccessState) {
                  final subCubit = state.subServiceListModel;
    
                  if (subCubit.services?.length == 0) {
                    return CenterMessage("no_services_yet".tr());
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: subCubit.services?.length,
                      itemBuilder: (context, index) {
                        var item = subCubit.services?[index];
                        print("sub list id ::::::::::::: ${item?.id}");
                        print(
                            "sub service length ::::::::::::: ${subCubit.services?.length}");
                        return SubServiceCard(
                          serviceId: item?.id,
                          subName: context.locale.languageCode == "ar"
                              ? "${item?.nameAr}"
                              : "${item?.nameEn}",
                        );
                      },
                    );
                  }
                } else if (state is SubServiceListErrorState) {
                  return CenterMessage(state.error);
                } else {
                  return CenterMessage("no_services_yet".tr());
                }
              })),
              _AddServiceButton(mainServiceId: widget.mainServiceId),
            ],
          ),
        ),
      ),
    );
  }
}

class SubServiceCard extends StatefulWidget {
  final int? serviceId;
  final String? subName;
  const SubServiceCard({Key? key, this.subName, this.serviceId})
      : super(key: key);

  @override
  State<SubServiceCard> createState() => _SubServiceCardState();
}

class _SubServiceCardState extends State<SubServiceCard> {
  @override
  void initState() {
    context.read<EndServiceListCubit>().endService(widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawHeaderText(text: widget.subName, fontSize: 14),
          BlocBuilder<EndServiceListCubit, EndServiceListState>(
              builder: (context, state) {
            if (state is EndServiceListLoadingState) {
              return CenterLoading();
            } else if (state is EndServiceListSuccessState) {
              final endCubit = state.endListModel;
              if (endCubit.services?.length == 0) {
                return CenterMessage("no_services_yet".tr());
              } else {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: endCubit.services?.length,
                  itemBuilder: (context, index) {
                    var item = endCubit.services?[index];
                    return _EndServiceCard(
                      endServiceName: context.locale.languageCode == "ar"
                          ? "${item?.nameAr}"
                          : "${item?.nameEn}",
                      price: item?.price,
                      desc: "${item?.descreption}",
                      endServiceId: item?.id,
                    );
                  },
                );
              }
            } else if (state is EndServiceListErrorState) {
              return CenterMessage(state.error);
            } else {
              return CenterMessage("no_services_yet".tr());
            }
          })
        ],
      ),
    );
  }
}

class _EndServiceCard extends StatelessWidget {
  final String? endServiceName;
  final String? price;
  final String? desc;
  final int? endServiceId;
  _EndServiceCard(
      {Key? key, this.endServiceName, this.price, this.desc, this.endServiceId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7.5,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawHeaderText(text: endServiceName, fontSize: 13),
              CustomRichText(
                  title: "price".tr(),
                  subTitle: "$price ${"sar".tr()}",
                  fontSize: 13),
              InkWell(
                onTap: () => showCupertinoDialog(
                    context: context,
                    builder: (_) =>
                        DeleteServiceAlert(endServiceId: endServiceId)),
                child: Container(
                  padding: EdgeInsets.only(
                      left: context.locale.languageCode == "ar" ? 0 : 20,
                      right: context.locale.languageCode == "ar" ? 20 : 0),
                  color: Colors.transparent,
                  child: Image.asset("assets/icons/delete.png", height: 22),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          DrawSingleText(text: desc, fontSize: 13)
        ],
      ),
    );
  }
}

class _AddServiceButton extends StatelessWidget {
  final int? mainServiceId;
  const _AddServiceButton({Key? key, this.mainServiceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: "add_service".tr(),
        topPadding: 5,
        bottomPadding: 5,
        rightPadding: 15,
        leftPadding: 15,
        onTap: () {
          showCupertinoDialog(
              context: context,
              builder: (_) {
                return AddServiceDialog(mainServiceId: mainServiceId);
              });
        });
  }
}
