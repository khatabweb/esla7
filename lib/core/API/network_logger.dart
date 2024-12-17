import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';


class NetworkLogger {
  static final logger = InterceptorsWrapper(
    onRequest: (RequestOptions options, handler) {
      String headers = "";
      String body = "";
      String queryParameters = "";
      // For Print Header
      options.headers.forEach((key, value) => headers += "$key: $value |");

      // For Print Body
      if (options.data.runtimeType == FormData) {
        for (var i = 0; i < (options.data as FormData).fields.length; i++) {
          (options.data as FormData).fields[i];
          body +=
              '${(options.data as FormData).fields[i].key}: ${(options.data as FormData).fields[i].value} | ';
        }
      } else if (options.data.runtimeType is Map) {
        (options.data as Map).forEach((key, value) => body += "$key: $value |");
      } else {
        body = "${options.data}";
      }
      // For Print queryParameters
      options.queryParameters
          .forEach((key, value) => queryParameters += "$key: $value |");
      log(
          "┌------------------------------------------------------------------------------");
      log('''| Request: ${options.method} ${options.uri}''');
      log(
          "├------------------------------------------------------------------------------");
      log('''| Headers: $headers''');
      log(
          "├------------------------------------------------------------------------------");
      log('''| Body: $body''');
      log(
          "├------------------------------------------------------------------------------");
      log('''| QueryParameters: $queryParameters''');
      log(
          "├------------------------------------------------------------------------------");
      handler.next(options);
    },
    onResponse: (Response response, handler) async {
      JsonEncoder encoder = const JsonEncoder.withIndent('        ');
      String prettyprint = encoder.convert(response.data);
      log("| Status code: ${response.statusCode}");
      log(
          "├------------------------------------------------------------------------------");
      log("| Response: $prettyprint");
      log(
          "└------------------------------------------------------------------------------");
      log(
          "================================================================================");
      handler.next(response);
    },
    onError: (DioError error, handler) async {
      handler.next(error); //continue
    },
  );
}
