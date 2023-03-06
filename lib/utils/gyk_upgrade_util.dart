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
    if(content.isEmpty) {
      return '1、修复已知问题';
    } else {
      return content.join('\n');
    }
  }

}