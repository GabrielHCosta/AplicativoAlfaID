abstract class ILocalStorage {
  Future<String> get(String key);
  Future addStringToSF(String key, String value);
  Future addBoolToSF(String key, bool value);
  Future delete(String key);
}
