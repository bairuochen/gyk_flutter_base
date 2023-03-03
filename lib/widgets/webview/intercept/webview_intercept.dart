import 'package:gyk_flutter_base/widgets/webview/callback/webview_callback.dart';
import 'package:gyk_flutter_base/widgets/webview/gyk_webview_controller.dart';

typedef WebPageUrlIntercept = bool Function(String url, GYKWebviewController? controller);

/// url拦截抽象基础类
abstract class UrlIntercept {

  WebPageCallBack? webPageCallBack;

  final WebPageUrlIntercept _webPageUrlIntercept;

  GYKWebviewController? controller;

  UrlIntercept(this._webPageUrlIntercept);

  /// 基础拦截
  bool baseUrlIntercept(String url) {
    return _libUrlIntercept(url) || otherUrlIntercept(url);
  }

  /// 其他拦截
  bool otherUrlIntercept(String url) {
    return _webPageUrlIntercept.call(url, controller);
  }

  /// lib 库默认拦截
  bool _libUrlIntercept(String url) {
    return false;
  }
}