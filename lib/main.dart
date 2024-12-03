import 'package:esla7/Screens/Provider/ProviderMainPage/main_page.dart';
import 'package:esla7/Screens/User/MainPage/main_page.dart';
import 'package:esla7/Theme/color.dart';
import 'package:esla7/Screens/CommonScreen/Splash/Splash.dart';
import 'package:esla7/Screens/CommonScreen/UserOrProvider/UserOrProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

///================= MultiBlocProvider imports =====================
import 'Screens/User/Auth/SignUp/Bloc/cubit.dart';
import 'Screens/User/Auth/ConfirmCode/Bloc/cubit.dart';
import 'Screens/User/Auth/Login/Bloc/cubit.dart';
import 'Screens/CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Bloc/cubit.dart';
import 'Screens/User/Cart/bloc/cubit.dart';
import 'Screens/User/CheckOut/bloc/cubit.dart';
import 'Screens/User/MainPage/UserOrders/OrderDetails/bloc/cubit.dart';
import 'Screens/User/MainPage/UserOrders/OrderDetails/rate/bloc/cubit.dart';
import 'Screens/User/ProviderProfile/EndService/bloc/cubit.dart';
import 'Screens/User/ProviderProfile/OwnerDetails/Bloc/cubit.dart';
import 'Screens/User/Auth/ForgetPassword/Bloc/cubit.dart';
import 'Screens/User/Auth/SetNewPassword/Bloc/cubit.dart';
import 'Screens/User/Profile/EditProfile/bloc/cubit.dart';
import 'Screens/Provider/Auth/SignUp/bloc/cubit.dart';
import 'Screens/Provider/Auth/ConfirmCode/bloc/cubit.dart';
import 'Screens/Provider/Auth/Login/bloc/cubit.dart';
import 'Screens/Provider/Auth/ForgetPassword/bloc/cubit.dart';
import 'Screens/Provider/Auth/SetNewPassword/bloc/cubit.dart';
import 'Screens/Provider/provider_Services/Add_Service/Service_Name_List/bloc/cubit.dart';
import 'Screens/Provider/provider_Services/Add_Service/Sub_Service_List/bloc/cubit.dart';
import 'Screens/Provider/provider_Services/Add_Service/AddService/bloc/cubit.dart';
import 'Screens/User/ProviderProfile/SubService/bloc/cubit.dart';
import 'Screens/Provider/ProviderMainPage/ProviderOrders/OrderDetails/bloc/cubit.dart';
import 'Screens/Provider/ProviderMainPage/ProviderOrders/OrderDetails/buttons_bloc/accept/cubit.dart';
import 'Screens/Provider/ProviderMainPage/ProviderOrders/OrderDetails/buttons_bloc/refuse/cubit.dart';
import 'Screens/User/Search/bloc/cubit.dart';
import 'Screens/Provider/Create_Ad/CreateAdsForm/Ads_Subscripe_bloc/cubit.dart';
import 'Screens/Provider/ProviderProfile/EditProfile/bloc/cubit.dart';
import 'Screens/Provider/provider_Services/Services/bloc/endList/cubit.dart';
import 'Screens/Provider/provider_Services/Services/bloc/subList/cubit.dart';
import 'Screens/Provider/provider_Services/DialogsWidgets/delete_bloc/cubit.dart';
import 'Screens/User/SingleSection/owner_bloc/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await translator.init(
    localeType: LocalizationDefaultType.asDefined,
    languagesList: <String>['ar', 'en-gb'],
    assetsDirectory: 'assets/langs/',
  );

  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ownerToken = pref.getString("owner_token");
  String? userToken = pref.getString("user_token");
  String? type = pref.getString("type");
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIos;
  var initializationSettings;

  void _showNotification(var title, var body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(var title, var body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel_Name',
      channelDescription: 'channel_Description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      ticker: 'test ticker',
    );
    // AndroidNotificationDetails(
    //   'channel_ID',
    //   'channel_Name',
    //   channelDescription: 'channel_Description',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   ticker: 'test ticker',
    // );
    var iosChannelSpecifics =
        DarwinNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Custom_Sound');
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondRoute()));
            },
            isDefaultAction: true,
            child: Text('ok'),
          )
        ],
      ),
    );
  }

  void onSelectNotification(NotificationResponse? payload) {
    if (payload?.payload != null) {
      // debugPrint('Notification payload $payload');
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserOrProvider()));
  }

  final RemoteMessage message = RemoteMessage();
  FlutterRingtonePlayer player = FlutterRingtonePlayer();

  @override
  void initState() {
    print("hellllllllllllllllllooooooooooooo");
    // FirebaseMessaging.instance.getToken().then((value) async {
    //   SharedPreferences _pref = await SharedPreferences.getInstance();
    //   _pref.setString("google_token", value.toString());
    //   print("Token:: $value");
    // });
    ///======================== Welcome notification ========================
    _showNotification(
        "repair-إصلاح", "You will find all the services you need easily");
    initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    initializationSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIos);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
    super.initState();
    // FlutterRingtonePlayer.playNotification();
    // FirebaseMessaging().getToken().then((value) => print(value));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      _showNotification(
          message.notification!.title, message.notification!.body);
      player.playNotification(
        looping: false, // Android only - API >= 28
        volume: 0.1, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onLaunch: $message");
      _showNotification(
          message.notification!.title, message.notification!.body);
      player.playNotification(
        looping: false, // Android only - API >= 28
        volume: 0.1, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onResume: $message");
      _showNotification(
          message.notification!.title, message.notification!.body);
      player.playNotification(
        looping: false, // Android only - API >= 28
        volume: 0.1, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ///user bloc
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => ConfirmCodeCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ComplaintsCubit()),
        BlocProvider(create: (_) => UserResetCubit()),
        BlocProvider(create: (_) => UpdatePasswordCubit()),
        BlocProvider(create: (_) => OwnerDetailsCubit()),
        BlocProvider(create: (_) => UserUpdateCubit()),
        BlocProvider(create: (_) => UserOrderDetailsCubit()),
        BlocProvider(create: (_) => RateCubit()),
        BlocProvider(create: (_) => UserSubListCubit()),
        BlocProvider(create: (_) => UserEndListCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => CheckoutCubit()),
        BlocProvider(create: (_) => OwnersCubit()),

        ///provider bloc
        BlocProvider(create: (_) => OwnerSignUpCubit()),
        BlocProvider(create: (_) => OwnerVerifyCubit()),
        BlocProvider(create: (_) => OwnerLoginCubit()),
        BlocProvider(create: (_) => OwnerResetCubit()),
        BlocProvider(create: (_) => OwnerUpdatePassCubit()),
        BlocProvider(create: (_) => SubServiceCubit()),
        BlocProvider(create: (_) => ServiceNameCubit()),
        BlocProvider(create: (_) => AddServiceCubit()),
        BlocProvider(create: (_) => OwnerOrderDetailsCubit()),
        BlocProvider(create: (_) => AcceptCubit()),
        BlocProvider(create: (_) => RefuseCubit()),
        BlocProvider(create: (_) => SubServiceListCubit()),
        BlocProvider(create: (_) => EndServiceListCubit()),
        BlocProvider(create: (_) => AdsSubscribeCubit()),
        BlocProvider(create: (_) => OwnerUpdateCubit()),
        BlocProvider(create: (_) => DeleteServiceCubit()),
      ],
      child: MaterialApp(
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
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ThemeColor.mainBlue,
          colorScheme: ColorScheme.light(
            primary: ThemeColor.mainBlue,
            secondary: Colors.grey,
          ),
          fontFamily: "JannaLT-Regular",
        ),
        home: SplashScreen(
          screen: widget.screen,
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertPage'),
      ),
      body: Center(
        child: TextButton(
          child: Text('go Back ...'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
