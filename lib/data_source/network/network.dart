import 'package:get/get_connect/connect.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'currentEnv.baseUrl';
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
