import 'package:flutter/material.dart';
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

  final String _url;
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
            debugPrint('WebView加载进度: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('${GYKSystemUtil.packageInfo.appName}正在加载: $url');
          },
          onPageFinished: (String url) {
            _controller.runJavaScriptReturningResult('document.title').then((value) {
              widget.titleCallBack?.call(value.toString());
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('${GYKSystemUtil.packageInfo.appName}加载失败');
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
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
    _gykWebviewController = GYKWebviewController(_controller);
    widget.onGYKWebPageCreated?.call(_gykWebviewController!);
    widget.urlIntercept?.controller = _gykWebviewController;
    widget.javaScriptChannels?.gykWebviewController = _gykWebviewController;
  }

  @override
  void initState() {
    super.initState();
    initWebview();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: WebViewWidget(controller: _controller),
        ));
  }
}