import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home/home_page.dart';
import 'Notification/Notification_page.dart';
import 'UserOrders/UserOrders_view.dart';
import 'allChats/view.dart';

class MainPage extends StatefulWidget {
  final int? pageIndex;

  MainPage({this.pageIndex});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey _btmNavKey = GlobalKey();
  final String language = translator.currentLanguage;
  int? _selectedIndex = 0;
  bool? skip;

  var pages = [];

  whichPage() {
    if (widget.pageIndex == null) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex = widget.pageIndex as int;
      });
    }
  }

  void skipCase() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      skip = _pref.getBool("skip");
    });
    print("skip case ::::::::::: $skip");
  }

  @override
  void initState() {
    pages = [
      HomePage(),
      UserOrdersView(),
      NotificationPage(),
      AllChats(),
    ];
    whichPage();
    skipCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: skip == true ? HomePage() : pages[_selectedIndex!],
      bottomNavigationBar: skip == true
          ? null
          : Container(
              // height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -1),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      spreadRadius: 0.2,
                      blurRadius: 15,
                    )
                  ]),
              child: BottomNavigationBar(
                key: _btmNavKey,
                currentIndex: _selectedIndex!,
                unselectedItemColor: Theme.of(context).colorScheme.secondary,
                selectedItemColor: Theme.of(context).primaryColor,
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    label: "",
                    icon: _CustomIcon("assets/icons/home.png"),
                    activeIcon: _CustomActiveIcon("assets/icons/home.png"),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: _CustomIcon("assets/icons/orders.png"),
                    activeIcon: _CustomActiveIcon("assets/icons/orders.png"),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: _CustomIcon("assets/icons/bell.png"),
                    activeIcon: _CustomActiveIcon("assets/icons/bell.png"),
                  ),
                  BottomNavigationBarItem(
                    label: "",
                    icon: _CustomIcon("assets/icons/chat.png"),
                    activeIcon: _CustomActiveIcon("assets/icons/chat.png"),
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
    );
  }
}

class _CustomIcon extends StatelessWidget {
  final String? path;

  _CustomIcon(this.path);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path!,
      height: 25,
      width: 25,
      fit: BoxFit.cover,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}

class _CustomActiveIcon extends StatelessWidget {
  final String? path;

  _CustomActiveIcon(this.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/ellipse.png"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Image.asset(
          path!,
          height: 22,
          width: 22,
          fit: BoxFit.cover,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
