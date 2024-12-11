import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../model/model.dart';
import '../repo/chat_repo.dart';
import '../../../../../Widgets/helper/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  late ChatModel chatModel;

  Future<void> getMessage(int? id) async {
    emit(ChatLoading());
    Map<String, dynamic> _body = {
      "conversation_id": id,
    };
    FormData _formData = FormData.fromMap(_body);
    var response = await ChatRepo.getMessage(formData: _formData);
    response.when(success: (data) {
      chatModel = data;
      chatModel.data = chatModel.data!.reversed.toList();
      emit(ChatSuccess(chatModel: chatModel));
    }, failure: (error) {
      emit(ChatError(error: error.apiErrorModel.message!));
    });
    print("getConversationById controller $response");
  }

  Future<void> sendMessage({
    XFile? file,
    int? senderId,
    String? message,
    int? conversationId,
    int? receiverId,
  }) async {
    emit(ChatLoading());
    var id;
    if (CacheHelper.instance!
            .getData(key: "type", valueType: ValueType.string) ==
        'user') {
      id = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);
      print('user id : $id');
    } else {
      id = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);
      print('owner id : $id');
    }
    print("my id : $id");
    FormData _formData = FormData.fromMap({
      "sender_id": id,
      "receiver_id": receiverId,
      // "type": message == null ? 1 : 0,
      if (message != null) 'massage': message,
      if (file != null) 'file': await MultipartFile.fromFile(file.path),
      'conversation_id': conversationId,
    });
    final response = await ChatRepo.sendMessage(formData: _formData);

    response.when(success: (data) {
      emit(ChatSendSuccess());
    }, failure: (error) {
      emit(ChatError(error: error.apiErrorModel.message!));
    });
  }

  Future<int> startChat(int? docId) async {
    emit(ChatLoading());
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? id;
    if (CacheHelper.instance!
            .getData(key: "type", valueType: ValueType.string) ==
        'user') {
      id = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);
      print('user id : $id');
    } else {
      id = CacheHelper.instance!
          .getData(key: "owner_id", valueType: ValueType.int);
      print('owner id : $id');
    }
    final formData = FormData.fromMap(
        {'sender_id': id, 'receiver_id': docId, 'massage': 'Hello'});

    final response = await ChatRepo.startChat(formData: formData);
    response.when(success: (data) {
      emit(ChatStartSuccess());
      throw data;
    }, failure: (error) {
      emit(ChatError(error: error.apiErrorModel.message!));
      throw 0;
    });
  }
}
