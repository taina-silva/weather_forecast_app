// ignore_for_file: avoid-dynamic
import 'dart:developer' as dev;
import 'dart:isolate';

import 'package:flutter/foundation.dart';

class LoggerService {
  LoggerService() {
    Isolate.current.addErrorListener(isolateErrorListener);
  }

  SendPort get isolateErrorListener {
    return RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      final exception = errorAndStacktrace.first;
      final stackTrace = errorAndStacktrace[1];
      logError(exception, stackTrace);
    }).sendPort;
  }

  void log(String message) {
    if (!kReleaseMode) {
      dev.log('Logged message: $message');
    }
  }

  void logError(exception, StackTrace? stackTrace) {
    if (!kReleaseMode) {
      dev.log('Exception: ${exception.toString()}');
      dev.log('StackTrace: ${stackTrace.toString()}');
    }
  }
}
