import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {

  Dio? dio;

  RequestInterceptorHandler? mHandler;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    mHandler = handler;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (dio != null) {

    }
    super.onError(err, handler);
  }

  Future retryLoop(DioError err, ErrorInterceptorHandler handler, int retry) async {

  }
}