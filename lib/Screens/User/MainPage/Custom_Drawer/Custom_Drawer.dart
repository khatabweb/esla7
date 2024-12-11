import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../API/api_utility.dart';
import '../../../../Theme/color.dart';
import '../../../CommonScreen/DrawerPages/Views/AboutUs/AboutUs.dart';
import '../../../CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Complaints_and_suggestions.dart';
import '../../../CommonScreen/DrawerPages/Views/Language/change_language.dart';
import '../../../CommonScreen/DrawerPages/Views/TermsAndCondition/TermsAndCondition.dart';
import '../../../CommonScreen/DrawerPages/Views/helpScreen/help_screen.dart';
import '../../../CommonScreen/UserOrProvider/UserOrProvider.dart';
import '../../../Provider/Auth/SignUp/View/ProviderSignUp_page.dart';
import '../../../Widgets/AnimatedWidgets.dart';
import '../../../Widgets/CenterLoading.dart';
import '../../../Widgets/Custom_DrawText.dart';
import '../../../Widgets/Custom_RoundedPhoto.dart';
import '../../../Widgets/helper/cache_helper.dart';
import '../../../Widgets/login_dialog/custom_login_dialog.dart';
import '../../Profile/ProfileView/data/cubit/profile_cubit.dart';
import '../../Profile/ProfileView/profile_view.dart';

class DrawerView extends StatefulWidget {
  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final String language = translator.activeLanguageCode;

  // ProfileModel _profileModel = ProfileModel();
  // bool isLoading = true;
  bool? skip;

  void shared() async {
    setState(() {
      skip =
          CacheHelper.instance!.getData(key: "skip", valueType: ValueType.bool);
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getUserProfile();
    shared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> listTileData = [
      {
        "title": "profile".tr(),
        "icon": "assets/icons/profile.png",
        "onTap": () {
          skip == true
              ? showCupertinoDialog(
                  context: context, builder: (_) => LoginAlert())
              : Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Profile()));
        },
      },
      {
        "title": "register_as_provider".tr(),
        "icon": "assets/icons/ownerlogin.png",
        "onTap": () async {
          // SharedPreferences pref = await SharedPreferences.getInstance();
          // pref.clear();
          CacheHelper.instance!.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => ProviderSignUpPage()),
              (route) => false);
          FirebaseMessaging.instance.getToken().then((value) async {
            CacheHelper.instance!
                .setData("owner_google_token", value: value as String);
            print("Provider Token:: $value");
          });
        },
      },
      {
        "title": "terms_and_condition".tr(),
        "icon": "assets/icons/terms.png",
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => TermsAndCondition())),
      },
      {
        "title": "about_us".tr(),
        "icon": "assets/icons/aboutus.png",
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AboutUs())),
      },
      {
        "title": "help".tr(),
        "icon": "assets/icons/help.png",
        "onTap": () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HelpView(
                  isUser: true,
                ),
              ),
            ),
      },
      {
        "title": "feedback".tr(),
        "icon": "assets/icons/review.png",
        "onTap": () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => ComplaintsAndSuggestion())),
      },
      {
        "title": "language".tr(),
        "icon": "assets/icons/global.png",
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ChangeLanguage())),
      },
      {
        "title": skip == true ? "log_in".tr() : "log_out".tr(),
        "icon": "assets/icons/logout.png",
        "onTap": () async {
          CacheHelper.instance!.clear();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UserOrProvider()));
        },
      },
    ];

    final double listHeight = listTileData.length.toDouble();

    return Directionality(
      textDirection: language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.6,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          elevation: 20,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // padding: EdgeInsets.only(top: 35),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 35),
                  skip == true
                      ? SizedBox()
                      : BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileLoading) {
                              return CenterLoading();
                            } else if (state is ProfileSuccess) {
                              return _UserData(
                                name: BlocProvider.of<ProfileCubit>(context)
                                    .profileModel
                                    .name,
                                image:
                                    "${ApiUtl.main_image_url}${BlocProvider.of<ProfileCubit>(context).profileModel.image}",
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),

                  SizedBox(height: 5),
                  Divider(),

                  //============= drawer content =================
                  Container(
                    height: 58 * listHeight,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      itemCount: listTileData.length,
                      itemBuilder: (context, item) {
                        return _DrawerItem(
                          title: listTileData[item]["title"] as String?,
                          onTap:
                              listTileData[item]["onTap"] as void Function()?,
                          imgSrc: listTileData[item]["icon"] as String?,
                        );
                      },
                    ),
                  ),

                  Divider(),
                  _ShareContact(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserData extends StatelessWidget {
  final String? name;
  final String? image;
  const _UserData({Key? key, this.name, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      horizontalOffset: 50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 40,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Profile())),
              child: Column(
                children: [
                  CustomRoundedPhoto(
                    image: "$image",
                    radius: 45,
                    borderWidth: 1,
                    borderColor: Color(0xFFEEEEEE),
                    backgroundColor: Color(0xFFEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(1, 1))
                    ],
                  ),
                  SizedBox(height: 5),
                  DrawHeaderText(
                      text: "$name", fontSize: 15, color: ThemeColor.mainGold),
                ],
              ),
            ),
            Container(height: 50, width: 40, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final void Function()? onTap;
  final String? title, imgSrc;
  final Widget? trailing;

  _DrawerItem({this.onTap, this.title, this.imgSrc, this.trailing});

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgets(
      verticalOffset: 50,
      child: ListTile(
        // trailing: trailing ?? SizedBox(),
        onTap: onTap,
        title: Text(
          title ?? "",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
            fontFamily: "JannaLT-Bold",
          ),
        ),
        horizontalTitleGap: 0,
        leading: Image.asset(
          imgSrc ?? "",
          height: 20,
          width: 20,
          fit: BoxFit.contain,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _ShareContact extends StatelessWidget {
  const _ShareContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawHeaderText(
            text: "share_app".tr(),
            fontSize: 14,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/greyshare.png",
                  height: 25, width: 25, fit: BoxFit.contain),
              SizedBox(width: 10),
              Image.asset("assets/icons/whatsapp.png",
                  height: 25, width: 25, fit: BoxFit.contain),
              SizedBox(width: 10),
              Image.asset("assets/icons/twitter.png",
                  height: 25, width: 25, fit: BoxFit.contain),
            ],
          )
        ],
      ),
    );
  }
}
