import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_AppBar.dart';
import 'data/cubit/ad_features_terms_cubit.dart';

class AdFeaturesAndTerms extends StatefulWidget {
  AdFeaturesAndTerms({Key? key}) : super(key: key);

  @override
  State<AdFeaturesAndTerms> createState() => _AdFeaturesAndTermsState();
}

class _AdFeaturesAndTermsState extends State<AdFeaturesAndTerms> {
  @override
  void initState() {
    context.read<AdFeaturesTermsCubit>().getAdFeaturesTerms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarTitle: "ad_features_terms".tr(),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: BlocBuilder<AdFeaturesTermsCubit, AdFeaturesTermsState>(
        builder: (context, state) {
          if (state is AdFeaturesTermsLoading) {
            return CenterLoading();
          } else if (state is AdFeaturesTermsError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is AdFeaturesTermsSuccess) {
            final _adFeaturesTermsModel = state.adFeaturesTermsModel;
            return AnimatedWidgets(
              verticalOffset: 150,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        context.locale.languageCode == "ar"
                            ? "${_adFeaturesTermsModel.propagandasAr}"
                            : "${_adFeaturesTermsModel.propagandasEn}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          height: 1.8,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
