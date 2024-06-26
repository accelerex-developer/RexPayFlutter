import 'dart:convert';
import 'dart:io';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rexpay/src/core/api/service/custom_exception.dart';
import 'package:rexpay/src/core/api/service/error_util.dart';
import 'dart:async';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rexpay/src/core/constants/constants.dart';

// mixin BaseApiService {
//   final Map<String, String> headers = {
//     HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
//     HttpHeaders.userAgentHeader: "RexpayPlugin.platformInfo.userAgent",
//     HttpHeaders.acceptHeader: 'application/json'
//   };
//   final String baseUrl = 'https://pgs-sandbox.globalaccelerex.com';
// }

mixin BaseApiService {
  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Dio> getDio() async {
    Dio dio;
    BaseOptions _options = BaseOptions(
      headers: _requestHeaders,
      connectTimeout: 40000,
      receiveTimeout: 100000,
    );

    dio = Dio(_options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 10090,
    //   ),
    // );

    return dio;
  }

  Future<Response> apiPostRequests(String endPoint, Map<String, dynamic> credentials, {Map<String, dynamic>? header}) async {
    try {
      header ??= {};

      Dio dio = await getDio();
      final Response response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            ...header,
          },
        ));
      return response;
    } on DioError catch (e) {
      // debugPrint(e.toString());
      // print(e.toString());

      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<Response> apiGetRequests(String endPoint, {Map<String, dynamic>? header}) async {
    try {
      header ??= {};
      Dio dio = await getDio();
      Response response = await dio.get(
        endPoint,
        options: Options(headers: {
          ...header,
        }),
      );
      switch (response.statusCode) {
        case SERVER_OKAY:
          try {
            return response;
          } catch (e) {
            throw PARSING_ERROR;
          }
        case CREATED:
          try {
            return response.data;
          } catch (e) {
            throw PARSING_ERROR;
          }

        default:
          throw DioErrorUtil.normalizeError(response.data);
      }
    } on DioError catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
