import 'package:dio/dio.dart';
import 'package:gyk_flutter_base/constant/gyk_constant.dart';
import 'package:gyk_flutter_base/utils/gyk_cache_util.dart';

class PersistentInterceptor extends Interceptor {


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var headerPersistent = GYKCacheUtil.getPersistent(options.baseUrl, type: GYKConstant.headerPersistent);
    var urlPersistent = GYKCacheUtil.getPersistent(options.baseUrl, type: GYKConstant.urlPersistent);
    headerPersistent?.forEach((key, value) {
      options.headers[key] = value;
    });
    urlPersistent?.forEach((key, value) {
      options.queryParameters[key] = value;
    });
    super.onRequest(options, handler);
  }
}