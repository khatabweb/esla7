import '../EndService/EndService.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/CenterMessage.dart';
import '../../../Widgets/Custom_AppBar.dart';
import '../../../Widgets/Custom_TextFieldTap.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/cubit.dart';

class SubService extends StatefulWidget {
  final int? ownerId;

  SubService({Key? key, this.ownerId}) : super(key: key);

  @override
  State<SubService> createState() => _SubServiceState();
}

class _SubServiceState extends State<SubService> {
  final String language = translator.activeLanguageCode;
  bool isLoading = true;

  Future userSubService() {
    final cubit = UserSubListCubit.get(context);
    cubit.ownerId = widget.ownerId;
    print("owner idddddddddddddd :::: ${cubit.ownerId}");
    return cubit.userSubService();
  }

  @override
  void initState() {
    userSubService().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = UserSubListCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(context: context, appBarTitle: "choose_service_type".tr(), backgroundColor: Colors.white),
          body: isLoading
              ? CenterLoading()
              : cubit.subListModel.services?.length == 0 
                ? CenterMessage("there_are_no_sub_services_now".tr())
                : AnimatedWidgets(
                  verticalOffset: 150,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.subListModel.services?.length,
                    itemBuilder: (context, index) {
                      var item = cubit.subListModel.services?[index];
                      return _ServiceCard(
                        text: language == "ar"
                            ? "${item?.nameAr}"
                            : "${item?.nameEn}",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EndService(
                              serviceId: item?.id,
                              ownerId: widget.ownerId,
                              appBarTitle: language == "ar"
                                  ? "${item?.nameAr}"
                                  : "${item?.nameEn}",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String? text;
  final void Function()? onTap;

  const _ServiceCard({Key? key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldTap(
      width: MediaQuery.of(context).size.width,
      height: 60,
      horizontalPadding: 15,
      color: Color(0xFFEEEEEE),
      label: text,
      labelSize: 14,
      fontFamily: "JannaLT-Bold",
      onTap: onTap,
    );
  }
}