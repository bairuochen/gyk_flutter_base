/// GYK app 信息
class GYKAppInfo {

  /// 下载地址
  String downloadUrl;

  /// 更新内容
  List<String> content;

  /// app 版本号
  String apkVersionName;

  /// app 版本编译号
  int apkVersionCode;

  /// 是否强制更新
  bool forceUpgrade;

  /// ios 更新地址（APP Store）
  String? iosUrl;

  /// 包名
  String? packageName;

  GYKAppInfo({
    required this.downloadUrl,
    required this.apkVersionName,
    required this.apkVersionCode,
    required this.content,
    required this.forceUpgrade,
    this.iosUrl,
    this.packageName
});
}