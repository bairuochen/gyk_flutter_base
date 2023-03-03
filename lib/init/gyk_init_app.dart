import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/gyk_system_util.dart';

/// gyk 初始化入口
class GYKInitApp {

  static Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var package = await getPackageInfo();
    GYKSystemUtil.packageInfo = package;
  }
}