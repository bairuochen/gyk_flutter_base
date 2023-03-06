import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';
import 'package:gyk_flutter_base/models/app/gyk_app_info.dart';

/// GYK 升级工具类
class GYKUpgradeUtil {

  /// 升级
  static Future<void> appUpgrade(GYKAppInfo gykAppInfo) {
    UpdateModel updateModel = UpdateModel(
        gykAppInfo.downloadUrl,
        "${gykAppInfo.packageName}.apk",
        'ic_launcher',
        convertToContent(gykAppInfo.content),
        showNewerToast: true,
        apkVersionCode: gykAppInfo.apkVersionCode,
        apkVersionName: "V${gykAppInfo.apkVersionName}",
        iOSUrl: gykAppInfo.iosUrl,
        showiOSDialog: true,
        forcedUpgrade: gykAppInfo.forceUpgrade
    );
    return AzhonAppUpdate.update(updateModel);
  }

  static String convertToContent(List<String> content) {
    return '1.支持Android4.1及以上版本\n2.支持自定义下载过程\n3.支持通知栏进度条展示\n4.支持文字国际化\n5.使用Kotlin协程重构';
  }

}