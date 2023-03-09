import 'package:dio/dio.dart';
import 'package:gyk_flutter_base/constant/http_config.dart';
import 'package:gyk_flutter_base/http/interceptors/error_interceptor.dart';
import 'package:gyk_flutter_base/http/interceptors/persistent_interceptor.dart';
import 'package:gyk_flutter_base/http/interceptors/retry_on_connection_change_interceptor.dart';
import 'package:gyk_flutter_base/http/interceptors/time_interceptor.dart';

/// gyk http 工具类
class GYKHttpUtil {

  final String _baseUrl;

  final HttpConfig _config;

  final List<Interceptor> _interceptors;

  late Dio _dio;

  Dio get dio {
    return _dio;
  }

  GYKHttpUtil._internal(
      this._baseUrl,
      this._config,
      this._interceptors) {
    BaseOptions options = BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _config.connectTimeOut,
        receiveTimeout: _config.receiveTimeOut
    );
    _dio = Dio(options);
    var retryDio = Dio(options);
    for (var element in _interceptors) {
      if (element is RetryOnConnectionChangeInterceptor) {
        element.dio = retryDio;
      } else if (element is ErrorInterceptor) {
        retryDio.interceptors.add(element);
      }
      _dio.interceptors.add(element);
    }
    proxy(_dio);
    proxy(retryDio);
  }

  void proxy(Dio dio) {

  }

  static final Map _dioUtils = {};

  static GYKHttpUtil instance(String baseUrl, {
    HttpConfig? config,
    List<Interceptor>? interceptors,
    List<Interceptor>? applyInterceptors,
  }) {
    if (!_dioUtils.containsKey(baseUrl)) {
      List<Interceptor> defaultInterceptors = [
        PersistentInterceptor(),
        TimeInterceptor(),
        RetryOnConnectionChangeInterceptor(),
        ErrorInterceptor()
      ];
      var gykInterceptors = interceptors?? defaultInterceptors;
      if (applyInterceptors != null && applyInterceptors.isNotEmpty) {
        gykInterceptors.addAll(applyInterceptors);
      }
      _dioUtils[baseUrl] = GYKHttpUtil.instance(baseUrl,
          config: config?? HttpConfig(HttpConfigBuilder()),
          interceptors: gykInterceptors
      );
    }
    return _dioUtils[baseUrl];
  }
}