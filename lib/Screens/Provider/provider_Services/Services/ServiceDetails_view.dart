import 'package:esla7/Screens/Provider/provider_Services/Services/bloc/endList/cubit.dart';
import 'package:esla7/Screens/Provider/provider_Services/Services/bloc/subList/cubit.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Screens/Widgets/Custom_AppBar.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:esla7/Screens/Widgets/Custom_Button.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RichText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../Add_Service/AddService/AddService_dialog.dart';
import '../DialogsWidgets/DeleteService_alert.dart';

class ServiceDetails extends StatefulWidget {
  final int? mainServiceId;
  final String? mainServiceName;
  ServiceDetails({Key? key, this.mainServiceId, this.mainServiceName}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String language = translator.activeLanguageCode;
  bool isLoading = true;

  Future subService() {
    final subCubit = SubServiceListCubit.get(context);
    return subCubit.subService();
  }

  @override
  void initState() {
    subService().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subCubit = SubServiceListCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
                Expanded(
                  child: isLoading
                      ? CenterLoading()
                      : subCubit.subListModel.services?.length == 0
                          ? CenterMessage("no_services_yet".tr())
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: subCubit.subListModel.services?.length,
                              itemBuilder: (context, index) {
                                var item = subCubit.subListModel.services?[index];
                                print("sub list id ::::::::::::: ${item?.id}");
                                print("sub service length ::::::::::::: ${subCubit.subListModel.services?.length}");
                                return SubServiceCard(
                                  serviceId: item?.id,
                                  subName: language == "ar"
                                      ? "${item?.nameAr}"
                                      : "${item?.nameEn}",
                                );
                              },
                            ),
                ),
                _AddServiceButton(mainServiceId: widget.mainServiceId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SubServiceCard extends StatefulWidget {
  final int? serviceId;
  final String? subName;
  const SubServiceCard({Key? key, this.subName, this.serviceId}) : super(key: key);

  @override
  State<SubServiceCard> createState() => _SubServiceCardState();
}

class _SubServiceCardState extends State<SubServiceCard> {
  String language = translator.activeLanguageCode;
  bool isLoading = true;
  // late double endLength;

  Future endService() {
    final endCubit = EndServiceListCubit.get(context);
    return endCubit.endService(widget.serviceId);
  }

  @override
  void initState() {
    endService().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final endCubit = EndServiceListCubit.get(context);
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
          endCubit.endListModel.services?.length == 0 ? CenterMessage("") : Container(
            height: (MediaQuery.of(context).size.height / 6.8) * (endCubit.endListModel.services!.length.toDouble()),
            child: isLoading ? CenterLoading() : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: endCubit.endListModel.services?.length,
              itemBuilder: (context, index){
                var item = endCubit.endListModel.services?[index];
                return _EndServiceCard(
                  endServiceName: language == "ar"
                      ? "${item?.nameAr}"
                      : "${item?.nameEn}",
                  price: item?.price,
                  desc: "${item?.descreption}",
                  endServiceId: item?.id,
                );
              },
            ),
          ),
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
  _EndServiceCard({Key? key, this.endServiceName, this.price, this.desc, this.endServiceId}) : super(key: key);
  final String lang = translator.activeLanguageCode;

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
              CustomRichText(title: "price".tr(), subTitle: "$price ${"sar".tr()}", fontSize: 13),
              InkWell(
                onTap: () => showCupertinoDialog(context: context, builder: (_) => DeleteServiceAlert(endServiceId: endServiceId)),
                child: Container(
                  padding: EdgeInsets.only(left: lang == "ar" ? 0 : 20, right: lang == "ar" ? 20 : 0),
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
        showCupertinoDialog(context: context, builder: (_){
          return AddServiceDialog(mainServiceId: mainServiceId);
        });
      }
    );
  }
}