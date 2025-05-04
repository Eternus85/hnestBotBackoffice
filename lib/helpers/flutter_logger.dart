library flutter_logger;

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mutex/mutex.dart';
import 'package:path_provider/path_provider.dart';

import 'options.dart';

abstract class LoggerDelegate {
  rowReaded(String readed);
}

enum LogType {
  info("INFO"),
  debug("DEBUG"),
  error("ERROR");

  const LogType(this.value);

  final String value;
}

const couchBaseDateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";
var globalLogger = GlobalLogger.shared;

class GlobalLogger {
  static final GlobalLogger _singleton = GlobalLogger._internal();

  factory GlobalLogger() {
    return _singleton;
  }

  GlobalLogger._internal();

  static GlobalLogger shared = GlobalLogger();

  final m = Mutex();
  final _formatter = DateFormat('dd-MM-yyyy kk:mm:ss.SSS');
  Options? _options;

  Future<void> init(Options options) async {
    _options = options;
  }

  Future<String> get _localPath async {
    Directory directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/CLLogger.log');
  }

  Future<String> getFilePath() async {
    var dir = await _localPath;
    return '$dir/CLLogger.log';
  }

  error(String content) {
    assert(_options != null);
    _log(content, logType: LogType.error, writeToLog: _options!.writeToFile);
  }

  debug(String content) {
    assert(_options != null);
    _log(content, logType: LogType.debug, writeToLog: _options!.writeToFile && _options!.verboseLog == true);
  }

  info(String content) {
    assert(_options != null);
    _log(content, logType: LogType.info, writeToLog: _options!.writeToFile);
  }

  clearLog() {
    assert(_options != null);
    if (_options!.writeToFile) {
      _localFile.then((File value) {
        value.delete();
      });
    }
  }

  _writeToLog(String content, {LogType logType = LogType.info}) {
    try {
      _localFile.then((File localFile) {
        localFile.exists().then((file) {
          m.protect(() async => await _createAndWrite(!file, localFile, content));
        });
      });
    } catch (e) {
      stdout.writeln(e.toString());
      log(e.toString());
    }
  }

  _log(String content, {LogType logType = LogType.info, bool writeToLog = false}) {
    if (logType == LogType.error) {
      content = "$content\n----- CALLSTACK -----\n${StackTrace.current}";
    }

    var now = DateTime.now();
    var nctx = "${_formatter.format(now)} | $logType => $content";
    stdout.writeln(nctx);
    log("$nctx\n");

    if (writeToLog) {
      _writeToLog(nctx, logType: logType);
    }
  }

  _createAndWrite(bool create, File file, String nctx) async {
    if (create) {
      await file.create();
    }
    int size = await file.length();
    //value in MB
    var mb = size / 1048576;
    if (mb > 50) {
      await file.delete();
      await file.create();
    }
    await file.writeAsString("\n$nctx", mode: FileMode.append, flush: true);
  }
}
