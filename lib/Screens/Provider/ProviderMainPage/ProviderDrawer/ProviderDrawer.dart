import 'package:esla7/Screens/Widgets/CenterLoading.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/AboutUs/AboutUs.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Complaints_and_suggestions.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/Language/change_language.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/TermsAndCondition/TermsAndCondition.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/helpScreen/help_screen.dart';
import 'package:esla7/Screens/Provider/Account_statement/Account_Statement.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Create_ad.dart';
import 'package:esla7/Screens/Provider/ProviderAddresses/ProviderAddresses.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/profile_view.dart';
import 'package:esla7/Screens/CommonScreen/UserOrProvider/UserOrProvider.dart';
import 'package:esla7/Screens/Widgets/AnimatedWidgets.dart';
import 'package:esla7/Screens/Widgets/Custom_DrawText.dart';
import 'package:esla7/Screens/Widgets/Custom_RoundedPhoto.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

///================== profile api import ==========================
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/Api/controller.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/Api/model.dart';

class ProviderDrawerView extends StatefulWidget {
  @override
  State<ProviderDrawerView> createState() => _ProviderDrawerViewState();
}

class _ProviderDrawerViewState extends State<ProviderDrawerView> {
  final String language = translator.activeLanguageCode;
  OwnerProfileController _profileController = OwnerProfileController();
  OwnerProfileModel _profileModel = OwnerProfileModel();
  bool isLoading = true;
  
  void getData() async {
    _profileModel = await _profileController.getOwnerProfile();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, Object>> listTileData = [
      {
        "title" : "profile".tr(),
        "icon" : "assets/icons/profile.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderProfile())),
      },
      // {
      //   "title" : "my_addresses".tr(),
      //   "icon" : "assets/icons/locationblue.png",
      //   "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderAddresses())),
      // },
      {
        "title" : "create_an_ad".tr(),
        "icon" : "assets/icons/premium.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateAdvertising())),
      },
      // {
      //   "title" : "account_statement".tr(),
      //   "icon" : "assets/icons/invoice.png",
      //   "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountStatement())),
      // },
      {
        "title" : "terms_and_condition".tr(),
        "icon" : "assets/icons/terms.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => TermsAndCondition())),
      },
      {
        "title" : "about_us".tr(),
        "icon" : "assets/icons/aboutus.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => AboutUs())),
      },
      {
        "title" : "help".tr(),
        "icon" : "assets/icons/help.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpView())),
      },
      {
        "title" : "feedback".tr(),
        "icon" : "assets/icons/review.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComplaintsAndSuggestion())),
      },
      {
        "title" : "language".tr(),
        "icon" : "assets/icons/global.png",
        "onTap" : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChangeLanguage())),
      },
      {
        "title" : "log_out".tr(),
        "icon" : "assets/icons/logout.png",
        "onTap" : () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.clear();
          Navigator.push(context, MaterialPageRoute(builder: (_) => UserOrProvider()));
        },
      },
    ];

    final double listHeight = listTileData.length.toDouble();


    return Directionality(
      textDirection: language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: MediaQuery.of(context).size.width/1.6,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          elevation: 20,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 35),
                  isLoading
                      ? CenterLoading()
                      : _UserData(
                          name: _profileModel.companyName,
                          image: "http://www.repaairsa.com/${_profileModel.companyImage}",
                        ),
                  SizedBox(height: 5),
                  Divider(),

                  //============= drawer content =================
                  Container(
                    height: 58 * listHeight,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      itemCount: listTileData.length,
                      itemBuilder: (context, item){
                        return _DrawerItem(
                          title: listTileData[item]["title"] as String?,
                          onTap: listTileData[item]["onTap"] as void Function()?,
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
  _UserData({Key? key, this.name, this.image}) : super(key: key);
  final String lang = translator.activeLanguageCode;
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
              width: 50,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProviderProfile())),
              child: Column(
                children: [
                  CustomRoundedPhoto(
                    image: "$image",
                    radius: 40,
                    borderWidth: 1,
                    borderColor: Color(0xFFEEEEEE),
                    backgroundColor: Color(0xFFEEEEEE),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(1, 1)
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  DrawHeaderText(text: "$name",fontSize: 15,color: ThemeColor.mainGold),
                ],
              ),
            ),
            Container(height: 50, width: 50, color: Colors.transparent),
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
          title??"",
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
          DrawHeaderText(text: "share_app".tr(), fontSize: 14,),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/greyshare.png",height: 25, width: 25, fit: BoxFit.contain),
              SizedBox(width: 10),
              Image.asset("assets/icons/whatsapp.png",height: 25, width: 25, fit: BoxFit.contain),
              SizedBox(width: 10),
              Image.asset("assets/icons/twitter.png",height: 25, width: 25, fit: BoxFit.contain),
            ],
          )
        ],
      ),
    );
  }
}


