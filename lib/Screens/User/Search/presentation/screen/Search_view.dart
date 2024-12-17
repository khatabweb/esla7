import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../core/API/api_utility.dart';
import '../../../../Widgets/AnimatedWidgets.dart';
import '../../../../Widgets/CenterLoading.dart';
import '../../../../Widgets/CenterMessage.dart';
import '../../../../Widgets/Custom_Background.dart';
import '../../../ProviderProfile/OwnerDetails/presentation/screen/ProviderProfile.dart';
import '../../../SingleSection/presentation/widgets/SingleProviderCard.dart';
import '../widget/search_header.dart';
import '../../data/bloc/cubit.dart';
import '../../data/bloc/state.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //

  @override
  void initState() {
    context.read<SearchCubit>().searchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchHeader(context: context),
      body: CustomBackground(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return CenterLoading();
            } else if (state is SearchErrorState) {
              return CenterMessage("something_went_wrong".tr());
            } else if (state is SearchSuccessState) {
              if (state.searchModel.owners?.length == 0) {
                return CenterMessage("there_are_no_search_result".tr());
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: state.searchModel.owners?.length,
                    itemBuilder: (context, index) {
                      var item = state.searchModel.owners?[index];
                      return AnimatedWidgets(
                        verticalOffset: 50,
                        child: SingleProviderCard(
                          isGolden: false,
                          name: "${item?.ownerName}",
                          city: context.locale.languageCode == "ar"
                              ? "${item?.city?.nameAr}"
                              : "${item?.city?.nameEn}",
                          rate: item?.rate?.toInt() ?? 0,
                          serviceName: context.locale.languageCode == "ar"
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
                );
              }
            } else {
              return CenterMessage("not found data");
            }
          },
        ),
      ),
    );
  }
}
