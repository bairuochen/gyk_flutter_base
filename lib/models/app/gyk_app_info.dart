/// GYK app 信息
class GYKAppInfo {

  /// 下载地址
  String downloadUrl;

  /// 更新内容
  List<String> content;

  /// 安卓app 版本号
  String? androidApkVersionName;

  /// 安卓app 版本编译号
  int? androidApkVersionCode;

  /// ios app 版本号
  String? iosApkVersionName;

  /// ios app 版本编译号
  int? iosApkVersionCode;

  /// 是否强制更新
  bool forceUpgrade;

  /// ios 更新地址（APP Store）
  String? iosUrl;

  /// 包名
  String? packageName;

  GYKAppInfo({
    required this.downloadUrl,
    this.androidApkVersionName,
    this.androidApkVersionCode,
    this.iosApkVersionName,
    this.iosApkVersionCode,
    required this.content,
    required this.forceUpgrade,
    this.iosUrl,
    this.packageName
});
}