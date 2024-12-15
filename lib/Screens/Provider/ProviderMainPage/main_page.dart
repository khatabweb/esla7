import 'Home/presentation/screen/home_page.dart';
import 'Notification/presentation/screen/Provider_Notification.dart';
import 'ProviderOrders/ProviderOrders_view.dart';
import '../../User/MainPage/allChats/presentation/screen/view.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProviderMainPage extends StatefulWidget {
  final int? pageIndex;

  ProviderMainPage({this.pageIndex});

  @override
  _ProviderMainPageState createState() => _ProviderMainPageState();
}

class _ProviderMainPageState extends State<ProviderMainPage> {
  GlobalKey _btmNavKey = GlobalKey();

  int? _selectedIndex;

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

  @override
  void initState() {
    pages = [
      ProviderHomePage(),
      ProviderOrdersView(),
      ProviderNotification(),
      AllChats(isUser: false),
    ];
    whichPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex!],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -1),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 15,
              )
            ]),
        child: BottomNavigationBar(
          key: _btmNavKey,
          currentIndex: _selectedIndex!,
          iconSize: 25,
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
