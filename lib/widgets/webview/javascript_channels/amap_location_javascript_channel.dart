import 'package:flutter/src/widgets/framework.dart';
import 'package:gyk_flutter_base/utils/gyk_log_util.dart';
import 'package:gyk_flutter_base/widgets/webview/javascript_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/src/platform_webview_controller.dart';

/// 获取高德定位
class AMapLocationJavaScriptChannel extends JavaScriptChannels {

  @override
  Set<JavaScriptChannelParams>? otherJavascriptChannels(BuildContext context) {
    return {
      _getAMapLocation(context)
    };
  }

  JavaScriptChannelParams _getAMapLocation(BuildContext context) {
    var jName = "getAMapLocation";
    return JavaScriptChannelParams(name: jName, onMessageReceived: (JavaScriptMessage message) {
      logFunctionName(jName, message.message);
      GYKLogUtil.logInfo("调用获取坐标接口");
    });
  }
}