import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../../main.dart';
import '../../CommonScreen/UserOrProvider/UserOrProvider.dart';
import '../../CommonScreen/second_route/view.dart';

class FirebaseNotificationHelper {
  static final FirebaseNotificationHelper instance =
      FirebaseNotificationHelper._internal();

  factory FirebaseNotificationHelper() => instance;

  FirebaseNotificationHelper._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIos;
  var initializationSettings;

  FlutterRingtonePlayer player = FlutterRingtonePlayer();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  void onInt() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> initialize() async {
    await Firebase.initializeApp();

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

    // // Configure local notification plugin
    // const AndroidInitializationSettings androidSettings =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');

    // const DarwinInitializationSettings iosSettings =
    //     DarwinInitializationSettings();

    // const InitializationSettings initSettings = InitializationSettings(
    //   android: androidSettings,
    //   iOS: iosSettings,
    // );

    // _localNotificationsPlugin.initialize(
    //   initSettings,
    //   onDidReceiveNotificationResponse: _onSelectNotification,
    // );

    // // Create a notification channel
    // await _localNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(_channel);

    // // Set notification options for foreground
    // await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // // Handle background messages
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // // Listen for notifications
    // FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedNotification);
  }

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
      context: navigatorState.currentState!.context,
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
    Navigator.push(navigatorState.currentState!.context,
        MaterialPageRoute(builder: (context) => UserOrProvider()));
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }
}
