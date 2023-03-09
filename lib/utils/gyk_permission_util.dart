import 'package:permission_handler/permission_handler.dart';

import 'gyk_system_util.dart';

/// GYK 权限工具类
class GYKPermissionUtil {
  /// 基础权限申请
  static Future<void> initPermissions() async {
    if (await Permission.contacts.request().isGranted) return;

    await [Permission.storage, Permission.camera, Permission.location]
        .request();
  }

  /// 存储权限申请
  static Future<bool> storagePerm() async {
    PermissionStatus status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final statuses = await [Permission.storage].request();
      return statuses[Permission.storage] == PermissionStatus.granted;
    }
    return true;
  }

  /// 相册权限申请
  static Future<bool> cameraPerm() async {
    PermissionStatus status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      final statuses = await [Permission.camera].request();
      return statuses[Permission.camera] == PermissionStatus.granted;
    }
    return true;
  }

  /// 位置权限申请
  static Future<bool> locationPerm() async {
    if (GYKSystemUtil.isAndroid) {
      PermissionStatus status = await Permission.location.status;
      if (status != PermissionStatus.granted) {
        final statuses = await [Permission.location].request();
        return statuses[Permission.location] == PermissionStatus.granted;
      }
      return true;
    } else if (GYKSystemUtil.isIOS) {
      PermissionStatus status = await Permission.locationWhenInUse.status;
      if (status != PermissionStatus.granted) {
        final statuses = await [Permission.locationWhenInUse].request();
        return statuses[Permission.locationWhenInUse] == PermissionStatus.granted;
      }
      return true;
    }
    return false;
  }

  /// app后台位置权限申请
  static Future<bool> locationBackPerm() async {
    PermissionStatus status = await Permission.locationAlways.status;
    if (status != PermissionStatus.granted) {
      final statuses = await [Permission.locationAlways].request();
      return statuses[Permission.locationAlways] == PermissionStatus.granted;
    }
    return true;
  }
}