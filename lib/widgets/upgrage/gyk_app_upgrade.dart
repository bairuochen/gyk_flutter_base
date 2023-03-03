import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';

/// app 升级组件
class GYKAppUpgrade {

  /// 升级
  static Future<void> appUpgrade(UpdateModel updateModel) {
    return AzhonAppUpdate.update(updateModel);
  }

}