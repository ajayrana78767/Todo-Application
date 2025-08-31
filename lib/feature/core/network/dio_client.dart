import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/feature/core/network/api_constants.dart';

class DioClient {
  // final Dio dio;

  // DioClient()
  //   : dio = Dio(
  //       BaseOptions(
  //         baseUrl: ApiConstants.baseUrl,
  //         receiveTimeout: Duration(seconds: 10),
  //         sendTimeout: Duration(seconds: 10),
  //       ),
  //     );
  final Dio dio;
  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("➡️ [REQUEST]");
          debugPrint("URL: ${options.uri}");
          debugPrint("Method: ${options.method}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ [RESPONSE]");
          debugPrint("Status Code: ${response.statusCode}");
          debugPrint("Data: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint("❌ [ERROR]");
          debugPrint("Type: ${error.type}");
          debugPrint("Message: ${error.message}");
          debugPrint("URL: ${error.requestOptions.uri}");
          if (error.response != null) {
            debugPrint("Status Code: ${error.response?.statusCode}");
            debugPrint("Error Data: ${error.response?.data}");
          }
          return handler.next(error);
        },
      ),
    );
  }

  // static final Dio dio = Dio(
  //   BaseOptions(
  //     baseUrl: ApiConstants.baseUrl,
  //     connectTimeout: Duration(seconds: 10),
  //     receiveTimeout: Duration(seconds: 10),
  //   )
  // );
}
