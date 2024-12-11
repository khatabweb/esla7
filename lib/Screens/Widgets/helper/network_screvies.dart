import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'cache_helper.dart';
import 'mapper.dart';
import 'network_logger.dart';

enum ServerMethods { GET, POST, UPDATE, DELETE, PUT, PATCH }

class NetworkHelper {
  static NetworkHelper? _instance;
  static String? lang;
  static Dio _dio = Dio();
  bool isActiveUser = true;
  NetworkHelper._private();

  factory NetworkHelper() {
    if (_instance == null) {
      _dio.options.connectTimeout = Duration(seconds: 60);
      _dio.interceptors.add(NetworkLogger.logger);
      _instance = NetworkHelper._private();
    }
    return _instance!;
  }

  Future<dynamic> request(
    String endpoint, {
    body,
    Mapper? model,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    ServerMethods method = ServerMethods.GET,
    bool isUser = true,
  }) async {
    String? _token = CacheHelper.instance!
        .getData(key: "user_token", valueType: ValueType.string);
    String? _ownerToken = CacheHelper.instance!
        .getData(key: "owner_token", valueType: ValueType.string);

    _dio.options.headers = {
      'Authorization': 'Bearer ${isUser ? _token : _ownerToken}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "User-Agent": "Dart",
      'Lang': lang,
    };
    if (header != null) {
      _dio.options.headers.addAll(header);
    }
    try {
      Response response = await _dio.request(
        endpoint,
        data: body,
        queryParameters: query,
        options: Options(
          method: method.name,
        ),
      );
      isActiveUser = true;
      if (model == null) {
        return response;
      } else {
        return Mapper(model, response.data);
      }
    } on SocketException catch (e) {
      log(
        "SocketException: ${e.address}",
        error: endpoint,
        name: "SocketException",
      );
      log("└------------------------------------------------------------------------------");
      log("================================================================================");
      rethrow;
    } on DioException catch (e) {
      log(
        "| Error: ${e.error}: ${e.response?.toString()}",
        error: "${endpoint}",
        name: "DioError",
      );
      log("└------------------------------------------------------------------------------");
      log("================================================================================");
      if (model == null) {
        return e.response;
      } else {
        return Mapper(model, e.response?.data);
      }
    } catch (error) {
      log(
        "Unhandled Exception: $error",
        error: endpoint,
        name: "Unhandled Exception",
      );
      log("└------------------------------------------------------------------------------");
      log("================================================================================");
      rethrow;
    }
  }
}
