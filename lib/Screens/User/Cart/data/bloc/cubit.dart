import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ProviderProfile/EndService/data/bloc/cubit.dart';
import '../repo/cart_repo.dart';
import 'state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState());

  static CartCubit get(context) => BlocProvider.of(context);
  String? lat, lang, address, resTime, resDate;
  XFile? image;

  Map<String, dynamic> userOrders = {};
  List<Map<String, dynamic>>? listt = [];

  Future<void> sendOrder(context) async {
    final cubit = UserEndListCubit.get(context);
    emit(CartLoadingState());

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

    FormData formData = FormData.fromMap(data);
    final response = await CartRepo.addToCart(formData: formData);

    response.when(success: (success) {
      emit(CartSuccessState());
      UserEndListCubit.get(context).cartItemList.clear();
    }, failure: (failure) {
      emit(CartErrorState(failure.apiErrorModel.message!));
    });
  }
}
