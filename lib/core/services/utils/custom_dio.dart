import 'package:dio/dio.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio();
  }

  CustomDio.withoutAuthentication() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onRespose, onError: _onError));
  }

  Dio get instance => _dio;

  _onRequest(RequestOptions options) async {
    options.connectTimeout = 20000;
    options.receiveTimeout = 15000;
  }

  _onError(DioError e) {
    if (e.response.statusCode == 404) {
      print("ERROR [${e.response.statusCode}] => PATH: ${e.request.path}");
      //print(e.response.statusCode);
      return "SORRY, RESOURCE DOESN'T EXIST";
    }
    if (e.response.statusCode == 403) {
      print("ERROR [${e.response.statusCode}] => PATH: ${e.request.path}");
      //print(e.response.statusCode);
      return "SORRY, RESOURCE DOESN'T EXIST";
    }
    return e;
  }

  _onRespose(Response e) {
    //print('########### Response Log');
    print(e.data);
    //print('########### Response Log');
  }

}