import 'package:get_storage/get_storage.dart';


class AppStorage {
  static GetStorage _box = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static void cacheToken(String value) => _box.write('token', value);
  static void cacheUserId(int value) => _box.write('user_id', value);

  static void cacheSocial(String value) => _box.write('social', value);

  static void cacheNotification(bool value) =>
      _box.write('notification', value);

  static void cacheId(int id) => _box.write('id', id);
  static void cacheOwnerId(int id) => _box.write('owner_id', id);
  static Future<void> cacheActive(bool value) async =>
      await _box.write('active', value);

  static void cacheUserNumber(String number) =>
      _box.write('user_number', number);
  // static Future<void> cacheUserAddress(AddressModel address) async =>
  //     await _box.write('user_address', address.toJson());

  // static Future<void> cacheUserToken(UserTokenModel user) async =>
  //     await _box.write('userToken', user.toJson());

  static String get getToken => _box.read('token') ?? "";
  static bool get getActive => _box.read('active') ?? false;

  static int get getId => _box.read('id') ?? 0;
  static int get getUserId => _box.read('user_id') ?? 0;

  static String? get getUserNumber => _box.read('user_number');
  // static AddressModel? get getUserAddress =>
  //     AddressModel.fromJson(_box.read('user_address'));

  static bool get isLogged => _box.hasData('userToken');

  static bool? get getNotification => _box.read('notification');

  static String? get currency => _box.read('currency');

  static void removeCache() {
    _box.erase();
  }

  static Future signOut({bool? clean}) async {
    removeCache();
    // NotificationsBloc.instance.isSeen = false;
    // CustomNavigator.push(Routes.SELECT_USER, clean: clean ?? true);
    // log("message :: signOut before ${Constants.device_id}");
    // await FirebaseMessaging.instance.deleteToken();
    // Constants.device_id = await FirebaseMessaging.instance.getToken();
    // log("message :: signOut after ${Constants.device_id}");
  }
}
