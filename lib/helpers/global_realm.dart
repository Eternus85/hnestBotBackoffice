import 'dart:io';
import 'package:hnest/helpers/flutter_logger.dart';
import 'package:realm/realm.dart';

var globalRealm = RealmProvider.shared;

class RealmProvider {
  static final RealmProvider _singleton = RealmProvider._internal();
  Configuration? _config;
  Realm? _realm;
  Transaction? currentTransaction;

  factory RealmProvider() {
    return _singleton;
  }

  RealmProvider._internal();

  static RealmProvider shared = RealmProvider();

  void init() {
    _config = Configuration.local([
      //Log.schema,
    ], schemaVersion: 35);
    if (_config != null) {
      try {
        _realm = Realm(_config!);
      } on RealmException catch (e) {
        globalLogger
            .error("RealmException during realm init. Deleting the realm file and retry. Error: ${e.toString()}");
        File(_config!.path).deleteSync();
        _realm = Realm(_config!);
      }
    }
  }

  bool isValidRealm() {
    return _realm != null && _realm?.isClosed == false;
  }

  List<T>? getAllOf<T extends RealmObject>() {
    if (!isValidRealm()) {
      init();
    }

    return _realm?.all<T>().toList();
  }

  List<T>? query<T extends RealmObject>(String query, [List<Object?> args = const []]) {
    if (!isValidRealm()) {
      init();
    }

    return _realm?.query<T>(query, args).toList();
  }

  beginTransaction() {
    if (!(_realm?.isInTransaction ?? false)) {
      currentTransaction = _realm?.beginWrite();
    }
  }

  commit() {
    if (_realm?.isInTransaction ?? false) {
      currentTransaction?.commit();
      currentTransaction = null;
    }
    //close();
  }

  rollback() {
    currentTransaction?.rollback();
    currentTransaction = null;
  }

  Future<void> addAll(List<RealmObject> objs, {bool closeDb = false}) async {
    if (!isValidRealm()) {
      init();
    }
    try {
      beginTransaction();
      _realm?.addAll(objs, update: true);
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
    }
  }

  addObject(RealmObject obj, {bool closeDb = false}) {
    if (!isValidRealm()) {
      init();
    }
    try {
      if (_realm?.isInTransaction ?? false) {
        _realm?.add(obj, update: true);
        return;
      }
      beginTransaction();
      _realm?.add(obj, update: true);
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
    }
  }

  Future<void> addObjectAsync(RealmObject obj, {bool closeDb = false}) async {
    if (!isValidRealm()) {
      init();
    }
    try {
      beginTransaction();
      _realm?.add(obj, update: true);
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
    }
  }

  void removeObjectsById<T extends RealmObject>(List<String> ids, {bool closeDb = false}) {
    if (!isValidRealm()) {
      init();
    }
    try {
      var nIds = ids.map((e) => '"$e"');
      var idsToRemove = nIds.reduce((value, element) => "$value,$element");
      List<T> toDelete = _realm?.query<T>('id IN {$idsToRemove}', []).toList() ?? [];
      if (_realm?.isInTransaction ?? false) {
        _realm?.deleteMany(toDelete);
        return;
      }
      beginTransaction();
      _realm?.deleteMany(toDelete);
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
    }
  }

  void removeObject(RealmObject obj, {bool closeDb = false}) {
    if (!isValidRealm()) {
      init();
    }
    try {
      if (_realm?.isInTransaction ?? false) {
        _realm?.delete(obj);
        return;
      }
      beginTransaction();
      _realm?.delete(obj);
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
    }
  }

  getTransaction(Function() fn, {bool closeDb = false}) {
    if (!isValidRealm()) {
      init();
    }
    try {
      beginTransaction();
      fn();
      commit();
      if (closeDb) {
        close();
      }
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
      rethrow;
    }
  }

  bool deleteAll<T extends RealmObject>({bool closeDb = false}) {
    if (!isValidRealm()) {
      init();
    }
    try {
      if (_realm?.isInTransaction ?? false) {
        _realm?.deleteAll<T>();
        return true;
      }
      beginTransaction();
      _realm?.deleteAll<T>();
      commit();
      if (closeDb) {
        close();
      }
      return true;
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
      return false;
    }
  }

  bool clearRealm() {
    try {
      if (!isValidRealm()) {
        init();
      }
      beginTransaction();

      //_realm?.deleteAll<DevicesList>();

      commit();
      close();
      return true;
    } catch (ex) {
      rollback();
      globalLogger.error(ex.toString());
      return false;
    }
  }

  void close() {
    if (!isValidRealm()) {
      init();
    }
    _realm?.close();
  }
}
