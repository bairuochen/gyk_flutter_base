import 'package:flutter/material.dart';
import 'package:gyk_flutter_base/utils/gyk_log_util.dart';
import 'package:gyk_flutter_base/utils/gyk_system_util.dart';
import 'package:gyk_flutter_base/widgets/webview/callback/webview_callback.dart';
import 'package:gyk_flutter_base/widgets/webview/gyk_webview_controller.dart';
import 'package:gyk_flutter_base/widgets/webview/intercept/webview_intercept.dart';
import 'package:gyk_flutter_base/widgets/webview/javascript_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// gyk webview 组件
class GYKWebviewPage extends StatefulWidget {

  /// 加载url
  final String _url;

  /// webview 加载完成title回调
  TitleCallBack? titleCallBack;
  JavaScriptChannels? javaScriptChannels;
  UrlIntercept? urlIntercept;
  GYKWebPageCreatedCallback? onGYKWebPageCreated;
  WebResourceErrorCallback? onWebResourceError;

  GYKWebviewPage(this._url, {
    this.titleCallBack,
    this.javaScriptChannels,
    this.urlIntercept,
    this.onGYKWebPageCreated,
    this.onWebResourceError,
    super.key});

  @override
  State<GYKWebviewPage> createState() => _GYKWebviewState();
}

class _GYKWebviewState extends State<GYKWebviewPage> {

  late WebViewController _controller;
  GYKWebviewController? _gykWebviewController;

  /// 初始化webview
  initWebview() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            GYKLogUtil.logInfo('WebView加载进度: $progress%');
          },
          onPageStarted: (String url) {
            GYKLogUtil.logInfo('${GYKSystemUtil.packageInfo.appName}正在加载: $url');
          },
          onPageFinished: (String url) {
            _controller.runJavaScriptReturningResult('document.title').then((value) {
              widget.titleCallBack?.call(value.toString());
            });
          },
          onWebResourceError: (WebResourceError error) {
            GYKLogUtil.logError('${GYKSystemUtil.packageInfo.appName}加载失败');
            widget.onWebResourceError?.call(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            //拦截处理
            if (widget.urlIntercept?.baseUrlIntercept(request.url)??false) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget._url));
    var javaScriptChannels = widget.javaScriptChannels?.baseJavaScriptChannels(context);
    if (javaScriptChannels != null && javaScriptChannels.isNotEmpty) {
      for (var javaScriptChannel in javaScriptChannels) {
        controller.addJavaScriptChannel(
            javaScriptChannel.name,
            onMessageReceived: javaScriptChannel.onMessageReceived);
      }
    }
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
    _gykWebviewController = GYKWebviewController(_controller);
    widget.urlIntercept?.controller = _gykWebviewController;
    widget.javaScriptChannels?.gykWebviewController = _gykWebviewController;
    widget.onGYKWebPageCreated?.call(_gykWebviewController!);
  }

  @override
  void initState() {
    super.initState();
    initWebview();
  }

  /// 退出APP
  Future<bool> _exitApp(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: WebViewWidget(controller: _controller),
            )));
  }
}