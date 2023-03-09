import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {

  Future<bool> isConnected() async {
    return true;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.unknown) {

    }
    super.onError(err, handler);
  }
}