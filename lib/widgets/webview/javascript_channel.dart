import 'package:flutter/cupertino.dart';
import 'package:gyk_flutter_base/widgets/webview/callback/webview_callback.dart';
import 'package:gyk_flutter_base/widgets/webview/gyk_webview_controller.dart';
import 'package:webview_flutter_platform_interface/src/webview_flutter_platform_interface_legacy.dart';

abstract class JavaScriptChannels {

  WebPageCallBack? webPageCallBack;

  GYKWebviewController? gykWebviewController;

  JavaScriptChannels();

  /// log日志
  void logFunctionName(String functionName, String data) {
    debugPrint("JS functionName -> $functionName JS params -> $data");
  }

  Set<JavascriptChannel>? baseJavaScriptChannels(BuildContext context) {
    var javascriptChannels = { _alertJavascriptChannel(context) };
    var other = otherJavascriptChannels(context);
    if (other != null) {
      javascriptChannels.addAll(other);
    }
    return javascriptChannels;
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    var jName = "Toast";
    return JavascriptChannel(name: jName, onMessageReceived: (JavascriptMessage message) {
      logFunctionName(jName, message.message);
    });
  }

  Set<JavascriptChannel>? otherJavascriptChannels(BuildContext context);
}