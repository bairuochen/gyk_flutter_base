import 'dart:developer' as developer;

import 'package:logger/logger.dart';

/// 日志工具类
class GYKLogUtil {

   static final Logger logger = Logger();

   /// 信息
   static void logInfo(dynamic msg) {
     logger.i(msg);
   }

   /// 成功
   static void logSuccess(dynamic msg) {
     logger.v(msg);
   }

   /// 警告
   static void logWarning(dynamic msg) {
     logger.d(msg);
   }

   /// 错误
   static void logError(dynamic msg) {
     logger.e(msg);
   }
}