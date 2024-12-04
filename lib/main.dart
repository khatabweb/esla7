import 'package:esla7/Screens/Widgets/helper/bloc_observe.dart';
import 'package:esla7/Screens/Widgets/helper/cach_helper.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'package:esla7/Theme/app_themedate.dart';
import 'Screens/Widgets/helper/app_storg.dart';
import 'Screens/Widgets/helper/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'Screens/CommonScreen/Splash/Splash.dart';
import 'Screens/CommonScreen/UserOrProvider/UserOrProvider.dart';
import 'Screens/Provider/ProviderMainPage/main_page.dart';
import 'Screens/User/MainPage/main_page.dart';
import 'Screens/Widgets/helper/bloc_providers.dart';

GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppStorage.init();
  await CacheHelper.init();
  FirebaseMessaging.instance.requestPermission();
  FirebaseNotificationHelper.instance.onInt();
  Bloc.observer = MyBlocObserver();

  await translator.init(
    localeType: LocalizationDefaultType.asDefined,
    languagesList: <String>['ar', 'en-gb'],
    assetsDirectory: 'assets/langs/',
  );

  // SharedPreferences pref = await SharedPreferences.getInstance();
  String? ownerToken = CacheHelper.instance!
      .getData(key: "owner_token", valueType: ValueType.string);
  final userId =
      CacheHelper.instance!.getData(key: "user_id", valueType: ValueType.int);
  print("userId of User : ............ $userId");
  String? userToken = CacheHelper.instance!
      .getData(key: "user_token", valueType: ValueType.string);
  String? type =
      CacheHelper.instance!.getData(key: "type", valueType: ValueType.string);
  Widget? screen;
  if (ownerToken == null && userToken == null) {
    screen = UserOrProvider();
  } else if (userToken != null && type == "user") {
    screen = MainPage();
  } else if (ownerToken != null && type == "owner") {
    screen = ProviderMainPage();
  } else {
    screen = UserOrProvider();
    print("type of User : ............ $type");
  }
  runApp(LocalizedApp(child: Repair(screen: screen)));
}

class Repair extends StatefulWidget {
  final Widget? screen;
  const Repair({Key? key, this.screen}) : super(key: key);
  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  @override
  void initState() {
    ///======================== Welcome notification ========================
    FirebaseNotificationHelper.instance.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkHelper.lang = translator.activeLanguageCode;
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        navigatorKey: navigatorState,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: translator.activeLocale,
        supportedLocales: [
          const Locale('en', 'gb'),
          const Locale('ar', ''),
        ],
        theme: AppTheme.lightTheme,
        home: SplashScreen(screen: widget.screen),
      ),
    );
  }
}
