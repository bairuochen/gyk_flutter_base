import 'package:logger/logger.dart';

class MyPrinter extends LogPrinter {

  static const String logPre = "猎运通: ";

  @override
  List<String> log(LogEvent event) {
    return [MyPrinter.logPre + event.message];
  }

}