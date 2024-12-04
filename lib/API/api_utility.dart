class ApiUtl {
  static const String main_network_url = "http://repaairsa.com/";
  static const String main_api_url = "http://repaairsa.com/api/";
  static const String main_owner_api_url = "http://repaairsa.com/owner/";
  static const String main_image_url = "http://www.repaairsa.com/";
  // https://repaairsa.com/api/owners

  // static const String main_banners_image_url = "http://www.repaairsa.com/uploads/banners/";
  // static const String main_users_image_url = "http://www.repaairsa.com/uploads/users/";

  ///========================= user API utilities ==============================
  static const String user_register = "${main_api_url}register";
  // http://repaairsa.com/api/register

  static const String user_login = "${main_api_url}login";

  static const String user_verify_code = "${main_api_url}verify";

  static const String user_reset_password = "${main_api_url}reset";

  static const String user_update_password = "${main_api_url}updatepassword";

  static const String owner_details = "${main_api_url}ownerdetails";

  static const String user_update_data = "${main_api_url}user/update/";

  static const String user_order_details = "${main_api_url}order_details";

  static const String user_rate = "${main_api_url}rate";

  static const String user_sub_service = "${main_api_url}sublist";

  static const String user_end_service = "${main_api_url}endlist";

  static const String user_search = "${main_api_url}search";

  static const String user_cart = "${main_api_url}add-to-cart";

  static const String user_checkout = "${main_api_url}balance";

  static const String owners_list = "${main_api_url}ddss";

  ///========================= Owner API utilities ==============================
  static const String owner_register = "${main_owner_api_url}registerowner";

  static const String owner_verify = "${main_owner_api_url}verifyowner";

  static const String owner_login = "${main_owner_api_url}loginowner";

  static const String owner_reset_password =
      "${main_owner_api_url}resetownerpassword";

  static const String owner_update_password =
      "${main_owner_api_url}updateownerpassword";

  static const String owner_sub_service =
      "${main_owner_api_url}subserviceslist";

  static const String owner_end_service =
      "${main_owner_api_url}endserviceslist";

  static const String owner_add_service =
      "${main_owner_api_url}addendserviceslist";

  static const String owner_order_details =
      "${main_owner_api_url}order_details_owner";

  static const String owner_accept_order = "${main_owner_api_url}accept_order";

  static const String owner_refuse_order = "${main_owner_api_url}refuse_order";

  static const String owner_ads_subscribe = "${main_owner_api_url}subscripe";

  static const String owner_update_profile = "${main_owner_api_url}update/";

  static const String owner_delete_end_service =
      "${main_owner_api_url}deleteendserviceslist/";

  ///========================= common API utilities ==============================
  static const String complaints_and_suggestions =
      "${main_api_url}storecomplaints";
}
