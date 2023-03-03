import 'package:webview_flutter/webview_flutter.dart';

/// gyk webview 控制器
class GYKWebviewController {

  /// Webview原有管理器
  final WebViewController _controller;

  GYKWebviewController(this._controller);

  ///执行网页js，在原有基础上封装，只需要发送jsName与参数
  Future<void> runJavascript(String funcName,List? param,bool brackets) async {
    var javaScriptString = getJavaScriptString(funcName, param, brackets);
    await _controller.runJavaScript(javaScriptString);
  }

  ///带返回值执行网页js，在原有基础上封装，只需要发送jsName与参数
  Future<dynamic> runJavascriptReturningResult(String funcName,List? param,bool brackets) async {
    var javaScriptString = getJavaScriptString(funcName,param,brackets);
    return await _controller.runJavaScriptReturningResult(javaScriptString);
  }

  /// 是否可以返回
  Future<bool> canGoBack() {
    return _controller.canGoBack();
  }

  /// 返回网页历史
  Future<void> goBack() {
    return _controller.goBack();
  }

  Future<void> reload() {
    return _controller.reload();
  }

  /// 获取js请求（工具）
  String getJavaScriptString(String funcName, List? param,bool brackets) {
    var stringBuffer = StringBuffer(funcName);
    if (brackets) {
      stringBuffer.write("(");
    }
    if (param != null && param.isNotEmpty) {

    }
    return stringBuffer.toString();
  }
}