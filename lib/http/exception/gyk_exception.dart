import 'package:dio/dio.dart';

class GYKException implements Exception {

  final String _message;

  final int _code;

  int get code {
    return _code;
  }

  String get message {
    return _message;
  }

  GYKException(this._code, this._message);

  @override
  String toString() {
    return '$_code : $_message';
  }

  factory GYKException.create(DioError error) {
    switch(error.type) {
      case DioErrorType.cancel:
        return GYKException(-1, "请求取消");
      case DioErrorType.connectionTimeout:
        return GYKException(-1, "请求超时");
      case DioErrorType.sendTimeout:
        return GYKException(-1, "请求超时");
      case DioErrorType.receiveTimeout:
        return GYKException(-1, "响应超时");
      case DioErrorType.badResponse:
        try {
          int? errCode = error.response?.statusCode!;
          switch(errCode) {
            case 400:
              return GYKException(errCode!, "请求语法错误");
            case 401:
              return GYKException(errCode!, "没有权限");
            case 403:
              return GYKException(errCode!, "服务器拒绝执行");
            case 404:
              return GYKException(errCode!, "无法连接服务器");
            case 405:
              return GYKException(errCode!, "请求方法被禁止");
            case 500:
              return GYKException(errCode!, "服务器内部错误");
            case 502:
              return GYKException(errCode!, "无效的请求");
            case 503:
              return GYKException(errCode!, "服务器挂了");
            case 505:
              return GYKException(errCode!, "不支持HTTP协议请求");
            default:
              return GYKException(errCode!, error.response?.statusMessage??'');
          }
        } on Exception catch(_) {
          return GYKException(-1, '未知错误');
        }
      default:
        return GYKException(-1, error.message??'服务器开小差了, 请重试');
    }
  }
}