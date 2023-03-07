import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';
import 'package:gyk_flutter_base/init/gyk_init_app.dart';
import 'package:gyk_flutter_base/models/app/gyk_app_info.dart';
import 'package:gyk_flutter_base/utils/gyk_log_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// GYK 升级工具类
class GYKUpgradeUtil {

  /// 升级
  static appUpgrade(GYKAppInfo gykAppInfo) async {
    UpdateModel updateModel;
    if (defaultTargetPlatform == TargetPlatform.iOS && Platform.isIOS) {
      var needUpgrade = await checkIosUpdateState(gykAppInfo);
      if (!needUpgrade) {
        return;
      }
      updateModel = UpdateModel(
          gykAppInfo.downloadUrl,
          "${gykAppInfo.packageName}.apk",
          'ic_launcher',
          convertToContent(gykAppInfo.content),
          showNewerToast: false,
          apkVersionCode: gykAppInfo.iosApkVersionCode,
          apkVersionName: gykAppInfo.iosApkVersionName,
          iOSUrl: gykAppInfo.iosUrl,
          showiOSDialog: true,
          forcedUpgrade: gykAppInfo.forceUpgrade
      );
    } else if(defaultTargetPlatform == TargetPlatform.android && Platform.isAndroid) {
      updateModel = UpdateModel(
          gykAppInfo.downloadUrl,
          "${gykAppInfo.packageName}.apk",
          'ic_launcher',
          convertToContent(gykAppInfo.content),
          showNewerToast: false,
          apkVersionCode: gykAppInfo.androidApkVersionCode,
          apkVersionName: gykAppInfo.androidApkVersionName,
          iOSUrl: gykAppInfo.iosUrl,
          showiOSDialog: true,
          forcedUpgrade: gykAppInfo.forceUpgrade
      );
    } else {
      GYKLogUtil.logWarning("不支持更新");
      return;
    }
    AzhonAppUpdate.update(updateModel);
  }

  /// 转换更新内容
  static String convertToContent(List<String> content) {
    if(content.isEmpty) {
      return '1、修复已知问题';
    } else {
      return content.join('\n');
    }
  }

  /// ios 判断是否需要更新
  static Future<bool> checkIosUpdateState(GYKAppInfo gykAppInfo) async {
    var currentPackage = await GYKInitApp.getPackageInfo();
    var newPackage = PackageInfo(
        appName: currentPackage.appName,
        packageName: currentPackage.packageName,
        version: gykAppInfo.iosApkVersionName??'1.0.0',
        buildNumber: gykAppInfo.iosApkVersionCode != null ? gykAppInfo.iosApkVersionCode.toString(): '0'
    );
    /// 如果有新版本
    if (compareVersion(currentPackage, newPackage) < 0) {
      return true;
    }
    return false;
  }

  /// 比较版本号 如果版本号相等，返回 0,如果第一个版本号低于第二个，返回 -1，否则返回 1.
  static int compareVersion(PackageInfo currentPackage, PackageInfo newPackage) {
    var currentVersionName = currentPackage.version;
    var currentBuildCode = int.parse(currentPackage.buildNumber);
    var newVersionName = newPackage.version;
    var newBuildCode = int.parse(newPackage.buildNumber);
    var currentNumbers = currentVersionName.split(".");
    var newNumbers = newVersionName.split(".");
    for (var index = 0;index < currentNumbers.length;) {
      var currentCode = int.parse(currentNumbers[index]);
      var newCode = int.parse(newNumbers[index]);
      if (currentCode == newCode) {
        break;
      }
      if (currentCode < newCode) {
        return -1;
      } else {
        return 1;
      }
    }
    if (currentBuildCode < newBuildCode) {
      return -1;
    } else if (currentBuildCode > newBuildCode) {
      return 1;
    }
    return 0;
  }
}