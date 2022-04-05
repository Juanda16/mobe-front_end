import 'dart:convert';

import 'package:get/get_connect/connect.dart';

class BaseService extends GetConnect {
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('flutterapp:12345'));
  main() async {
    // String username = 'flutterapp';
    // String password = '12345';
    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('$username:$password'));
    // print(basicAuth);
    //
    // Response r = await get('https://api.somewhere.io',
    //     headers: <String, String>{'authorization': basicAuth});
    // print(r.statusCode);
    // print(r.body);
  }

  @override
  void onInit() {
    //httpClient.baseUrl = 'https://www.google.com';
    httpClient.baseUrl = 'https://mobe-backend.herokuapp.com';
  }

  Future<Response<T>> postReq<T>({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    // await NetworkInfo.isThereAnInternetConnection();
    //TODO: think about the response to avoid double feedback to the user
    print(basicAuth);
    return post(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  Future<Response<T>> putReq<T>({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) async {
    // await NetworkInfo.isThereAnInternetConnection();
    return put(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  Future<Response<T>> deleteReq<T>({
    required String url,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    // await NetworkInfo.isThereAnInternetConnection();
    return delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }

  Future<Response<T>> getReq<T>({
    required String url,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) async {
    // await NetworkInfo.isThereAnInternetConnection();
    return get(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }
}
