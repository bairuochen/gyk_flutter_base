import 'package:flutter/material.dart';
import 'package:gyk_flutter_base/utils/gyk_log_util.dart';
import 'package:gyk_flutter_base/widgets/webview/callback/webview_callback.dart';
import 'package:gyk_flutter_base/widgets/webview/gyk_webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/src/platform_webview_controller.dart';

abstract class JavaScriptChannels {

  WebPageCallBack? webPageCallBack;

  GYKWebviewController? gykWebviewController;

  JavaScriptChannels();

  /// log日志
  void logFunctionName(String functionName, String data) {
    GYKLogUtil.logInfo("JS functionName -> $functionName JS params -> $data");
  }

  Set<JavaScriptChannelParams>? baseJavaScriptChannels(BuildContext context) {
    var javascriptChannels = { _alertJavascriptChannel(context) };
    var other = otherJavascriptChannels(context);
    if (other != null) {
      javascriptChannels.addAll(other);
    }
    return javascriptChannels;
  }

  JavaScriptChannelParams _alertJavascriptChannel(BuildContext context) {
    var jName = "Toast";
    return JavaScriptChannelParams(name: jName, onMessageReceived: (JavaScriptMessage message) {
      logFunctionName(jName, message.message);
    });
  }

  Set<JavaScriptChannelParams>? otherJavascriptChannels(BuildContext context);
}