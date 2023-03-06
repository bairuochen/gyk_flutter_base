import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';

/// GYK 升级工具类
class GYKUpgradeUtil {

  /// 升级
  static Future<void> appUpgrade(UpdateModel updateModel) {
    return AzhonAppUpdate.update(updateModel);
  }

}