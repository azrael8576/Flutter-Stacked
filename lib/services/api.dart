import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutterstacked/utils/network_exception.dart';
import 'package:http/http.dart' as http;

import 'package:basic_utils/basic_utils.dart';
import 'package:flutterstacked/logger.dart';
import 'package:injectable/injectable.dart';

final log = getLogger('Api');

@lazySingleton
class Api{
  static int _mTimeout = 120;
  void init(int timeout) {
    _mTimeout = timeout == 0 ? '\uea60' : timeout;
  }

  Future<dynamic> get(String url, String action, Map<String, dynamic> params, Map<String, dynamic> header) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await HttpUtils.getForFullResponse(url + action, queryParameters: null, headers: header)
          .timeout(Duration(seconds: _mTimeout));
      responseJson = _returnResponse(response, action);
    } on SocketException {
      log.w(action + " 連線異常(逾時或無法連線)");
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      log.w(action + " 連線異常(逾時或無法連線)");
    } on Exception {
      log.w(action + " 發生例外錯誤");
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, String action, Map<String, dynamic> params, Map<String, dynamic> header, [int readTimeout]) async {
    if (readTimeout != null) {
      _mTimeout = readTimeout;
    }
    print('Api Post, url $url');
    var responseJson;
    try {
      log.d(action + " post param: " + jsonEncode(params));
      final response = await HttpUtils.postForFullResponse(url + action, body: jsonEncode(params), queryParameters: null, headers: header)
          .timeout(Duration(seconds: _mTimeout));

      responseJson = _returnResponse(response, action);
    } on SocketException {
      log.w(action + " 連線異常(逾時或無法連線)");
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      log.w(action + " 連線異常(逾時或無法連線)");
    } on Exception catch (e){
      log.w(action + " 發生例外錯誤 $e");
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, String action, Map<String, dynamic> params, Map<String, dynamic> header) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await HttpUtils.putForFullResponse(url + action, body: jsonEncode(params), queryParameters: null, headers: header)
          .timeout(Duration(seconds: _mTimeout));
      responseJson = _returnResponse(response, action);
    } on SocketException {
      log.w(action + " 連線異常(逾時或無法連線)");
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      log.w(action + " 連線異常(逾時或無法連線)");
    } on Exception {
      log.w(action + " 發生例外錯誤");
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url, String action, Map<String, dynamic> params, Map<String, dynamic> header) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await HttpUtils.deleteForFullResponse(url + action, queryParameters: null, headers: header)
          .timeout(Duration(seconds: _mTimeout));
      apiResponse = _returnResponse(response, action);
    } on SocketException {
      log.w(action + " 連線異常(逾時或無法連線)");
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      log.w(action + " 連線異常(逾時或無法連線)");
    } on Exception {
      log.w("ApiBaseHelper " + action + " 發生例外錯誤");
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response, String action) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      log.d(action + " request body: " + response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}