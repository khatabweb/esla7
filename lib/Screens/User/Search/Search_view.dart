import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/ProviderProfile/OwnerDetails/ProviderProfile.dart';
import 'package:esla7/Screens/User/SingleSection/widgets/SingleProviderCard.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Screens/Widgets/CenterMessage.dart';
import 'package:esla7/Screens/Widgets/Custom_Background.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bloc/cubit.dart';
import 'component/search_header.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final String language = translator.activeLanguageCode;
  bool isLoading = true;

  Future getSearch() async {
    final cubit = SearchCubit.get(context);
    return cubit.searchDetails();
  }

  @override
  void initState() {
    getSearch().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SearchCubit.get(context);
    return Directionality(
      textDirection: language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: searchHeader(context: context),
        body: CustomBackground(
          child: isLoading
              ? CenterLoading()
              : cubit.searchModel.owners?.length == 0 ? CenterMessage("there_are_no_search_result".tr()) : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.searchModel.owners?.length,
                    itemBuilder: (context, index) {
                      var item = cubit.searchModel.owners?[index];
                      return AnimatedWidgets(
                        verticalOffset: 50,
                        child: SingleProviderCard(
                          isGolden: false,
                          name: "${item?.ownerName}",
                          city: language == "ar"
                              ? "${item?.city?.nameAr}"
                              : "${item?.city?.nameEn}",
                          rate: item?.rate?.toInt() ?? 0,
                          serviceName: language == "ar"
                              ? "${item?.service?.nameAr}"
                              : "${item?.service?.nameEn}",
                          image: "${ApiUtl.main_image_url}${item?.ownerImage}",
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProviderProfile(
                                        ownerId: item?.id,
                                        mainServiceId: item?.service?.id,
                                      ))),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
