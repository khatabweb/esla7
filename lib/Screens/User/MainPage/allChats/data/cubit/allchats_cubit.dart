import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../repo/repo.dart';
import '../model/AllChatsModel.dart';
import '../../../../../Widgets/helper/cach_helper.dart';

part 'allchats_state.dart';

class AllChatsCubit extends Cubit<AllChatsState> {
  AllChatsCubit() : super(AllChatsInitial());
  late AllChatsModel? _allChatsModel;

  Future<void> getAllChats() async {
    emit(AllChatsLoading());

    var type =
        CacheHelper.instance!.getData(key: "type", valueType: ValueType.string);
    var id;
    if (type == 'user') {
      id = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);
      ;
      print('user id : $id');
    } else {
      id = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);
      print('owner id : $id');
    }
    Map<String, dynamic> _body = {
      "user_id": id,
    };

    FormData _formData = FormData.fromMap(_body);
    final response = await AllChatsRepo().getAllChats(formData: _formData);

    response.when(
      success: (data) {
        _allChatsModel = data;
        emit(AllChatsSuccess(allChatsModel: _allChatsModel!));
      },
      failure: (error) {
        emit(AllChatsError(error: error.apiErrorModel.message!));
      },
    );
  }
}
