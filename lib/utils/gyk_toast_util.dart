import 'package:fluttertoast/fluttertoast.dart';

/// gyk toast 工具类
class GYKToastUtil {

  /// 展示toast
  static Future<void> toast(String msg) async {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }

  /// 取消toast
  static Future<void> cancel() async {
    Fluttertoast.cancel();
  }

}