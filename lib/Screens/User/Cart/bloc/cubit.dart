import 'package:dio/dio.dart';
import '../../../../API/api_utility.dart';
import '../../ProviderProfile/EndService/bloc/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState());

  static CartCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? lat, lang, address, resTime, resDate;
  XFile? image;

  Map<String, dynamic> userOrders = {};
  List<Map<String, dynamic>>? listt = [];

  Future<void> sendOrder(context) async {
    final cubit = UserEndListCubit.get(context);
    emit(CartLoadingState());

    try {
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");

      dio.options.headers = {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Authorization": "Bearer $token",
      };

      //
      // FormData formData = FormData.fromMap({
      //   "lat" : lat,
      //   "lang" : lang,
      //   "address" : address,
      //   "res_time" : resTime,
      //   "res_date" : resDate,
      //   // "user_orders" : json.encode(listt),
      //   // '[${json.encode(CartItemModel(note: "gvreddfccscccdascs",quantity: 2,serviceId: 2,ownerId: 1,price: 50,serviceDesc: "dsa",name: "dcds",))}]'
      // });

      final Map<String, dynamic> data = {
        "lat": lat,
        "lang": lang,
        "address": address,
        "res_time": resTime,
        "res_date": resDate,
        // "user_orders" : json.encode(listt),
        // '[${json.encode(CartItemModel(note: "gvreddfccscccdascs",quantity: 2,serviceId: 2,ownerId: 1,price: 50,serviceDesc: "dsa",name: "dcds",))}]'
      };

      for (int i = 0; i < cubit.cartItemList.length; i++) {
        data.addAll({
          "user_orders[$i][owner_id]": cubit.cartItemList[i].ownerId,
          "user_orders[$i][service_id]": cubit.cartItemList[i].serviceId,
          "user_orders[$i][quantity]": cubit.cartItemList[i].quantity ?? 1,
          "user_orders[$i][price]": cubit.cartItemList[i].price,
          "user_orders[$i][note]": cubit.cartItemList[i].note,
          "user_orders[$i][service_desc]": cubit.cartItemList[i].serviceDesc,
          "user_orders[$i][name]": cubit.cartItemList[i].name,
          if (cubit.cartItemList[i].image != null)
            "user_orders[$i][image]":
                await MultipartFile.fromFile(cubit.cartItemList[i].image!.path),
        });

        // if(userOrders.isNotEmpty) {
        //   listt?.add(userOrders);
        //   print("Listttttt ::::: $listt");
        // }
      }

      print("orderrrs ::::::: $data");
      FormData formData = FormData.fromMap(data);
      final Response response =
          await dio.post(ApiUtl.user_cart, data: formData);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(CartSuccessState());
        UserEndListCubit.get(context).cartItemList.clear();
        print("list after clear $listt");
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("Cart error ::::::::::::::${response.data["message"]}");
        emit(CartErrorState(response.data["message"]));
      }
    } catch (e) {
      print("Cart catch error :::::::::::::: ${e.toString()}");
      emit(CartErrorState(e.toString()));
    }
  }
}
