// import 'package:dio/dio.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'data/model/model.dart';

// class ChatController {
//   ChatModel _chatModel = ChatModel();
//   NetWork _netWork = NetWork();
//   Future<ChatModel> getMessage(int? id) async {
//     Map<String, dynamic> _body = {
//       "conversation_id": id,
//     };
//     FormData _formData = FormData.fromMap(_body);
//     var response = await _netWork.postData(
//       url: 'api/getConversationById',
//       formData: _formData,
//     );
//     print("getConversationById controller $response");
//     if (response != null) {
//       _chatModel = ChatModel.fromJson(response);
//     } else {
//       _chatModel = ChatModel();
//     }
//     _chatModel.data = _chatModel.data!.reversed.toList();
//     return _chatModel;
//   }

//   Future<void> sendMessage(
//       {XFile? file,
//       int? senderId,
//       String? message,
//       int? conversationId,
//       int? receiverId}) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var id;
//     if (_prefs.getString("type") == 'user') {
//       id = _prefs.getInt("user_id");
//       print('user id : $id');
//     } else {
//       id = _prefs.getInt("owner_id");
//       print('owner id : $id');
//     }
//     print("my id : $id");
//     FormData _formData = FormData.fromMap({
//       "sender_id": id,
//       "receiver_id": receiverId,
//       // "type": message == null ? 1 : 0,
//       if (message != null) 'massage': message,
//       if (file != null) 'file': await MultipartFile.fromFile(file.path),
//       'conversation_id': conversationId,
//     });
//     var response = await _netWork.postData(
//       url: 'api/addMassage',
//       formData: _formData,
//     );
//     print(_formData.fields);
//     print("bdmfbkmfdklmbklmdfbklmdfklmblkfdmvkldfmvklmfdbklmfd$response");
//   }

//   Future<int> startChat(int? docId) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     int? id;
//     if (_prefs.getString("type") == 'user') {
//       id = _prefs.getInt("user_id");
//       print('user id : $id');
//     } else {
//       id = _prefs.getInt("owner_id");
//       print('owner id : $id');
//     }
//     final formData = FormData.fromMap(
//         {'sender_id': id, 'receiver_id': docId, 'massage': 'Hello'});
//     final response = await _netWork.postData(
//       url: 'api/addConversation',
//       formData: formData,
//     );

//     print(response['data']['conversation_id']);
//     return response['data']['conversation_id'];
//   }
//   // Future<int> updateMessage(int msgId)async{
//   //   SharedPreferences _prefs = await SharedPreferences.getInstance();
//   //   final formData = FormData.fromMap({
//   //     'massage_id': msgId,
//   //   });
//   //   final response = await _netWork.postData(url: 'api/update_view_message',formData: formData);
//   //   // print("تم");
//   //   return response['data']['id'];
//   // }
// }
