import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/gyk_system_util.dart';

/// gyk 初始化入口
class GYKInitApp {

  /// 初始化
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var package = await getPackageInfo();
    /// 初始化包信息
    GYKSystemUtil.packageInfo = package;
  }

  /// 获取包信息
  static Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}