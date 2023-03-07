import 'dart:developer' as developer;

/// 日志工具类
class GYKLogUtil {

   static const String logPre = "猎运通: ";

   /// 信息
   static void logInfo(String msg) {
     developer.log('\x1B[34m$logPre$msg\x1B[0m');
   }

   /// 成功
   static void logSuccess(String msg) {
     developer.log('\x1B[32m$logPre$msg\x1B[0m');
   }

   /// 警告
   static void logWarning(String msg) {
     developer.log('\x1B[33m$logPre$msg\x1B[0m');
   }

   /// 错误
   static void logError(String msg) {
     developer.log('\x1B[31m$logPre$msg\x1B[0m');
   }
}