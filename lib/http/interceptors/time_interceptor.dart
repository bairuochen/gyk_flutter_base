import 'package:dio/dio.dart';
import 'package:gyk_flutter_base/constant/sys_config.dart';

/// 超时拦截器
class TimeInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var extra = options.extra;
    bool connect = extra.containsKey(SysConfig.connectTimeOut);
    bool receive = extra.containsKey(SysConfig.receiveTimeOut);
    if (connect || receive) {
      if (connect) {
        int connectTimeOut = options.extra[SysConfig.connectTimeOut];
        options.connectTimeout = Duration(seconds: connectTimeOut);
      }
      if (receive) {
        int receiveTimeOut = options.extra[SysConfig.receiveTimeOut];
        options.receiveTimeout = Duration(seconds: receiveTimeOut);
      }
    }
    super.onRequest(options, handler);
  }
}