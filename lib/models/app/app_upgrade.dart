import 'download_status.dart';

class AppInfo {
  /// 版本名称
  String versionName;

  /// 版本号
  String versionCode;

  /// 包名
  String packageName;

  AppInfo({
    required this.versionName,
    required this.versionCode,
    required this.packageName
  });
}

class AppUpgradeInfo {
    /// 升级提示框标题
    final String title;

    /// 升级内容
    final List<String> content;

    /// apk下载url
    String? apkDownloadUrl;

    /// 是否强制升级
    final bool force;

    AppUpgradeInfo({
        required this.title,
        required this.content,
        this.apkDownloadUrl,
        this.force = false
    });
}

/// 下载进度回调
typedef DownloadProgressCallback = Function(int count, int total);

/// 下载状态变化回调
typedef DownloadStatusChangeCallback = Function(DownloadStatus downloadStatus, {dynamic error});