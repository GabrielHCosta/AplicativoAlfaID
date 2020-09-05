import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_interface.dart';

class LocalStorageShared implements ILocalStorage {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalStorageShared() {
    _init();
  }

  @override
  Future delete(String key) async {
    var shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future<String> get(String key) async {
    var shared = await _instance.future;
    return shared.getString(key);
  }

  @override
  Future addStringToSF(String key, String value) async {
    var shared = await _instance.future;
    shared.setString(key, value);
  }

  @override
  Future addBoolToSF(String key, bool value) async {
    var shared = await _instance.future;
    shared.setBool(key, value);
  }
}
