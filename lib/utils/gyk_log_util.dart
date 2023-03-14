import 'dart:developer' as developer;

import 'package:logger/logger.dart';

/// 日志工具类
class GYKLogUtil {

   static final Logger logger = Logger(
     printer: PrettyPrinter(
         methodCount: 0, // number of method calls to be displayed
         errorMethodCount: 8, // number of method calls if stacktrace is provided
         lineLength: 120, // width of the output
         colors: true, // Colorful log messages
         printEmojis: true, // Print an emoji for each log message
         printTime: false // Should each log print contain a timestamp
     ),
   );

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