abstract class AppPreference {

  void putString(String key, String value);

  void putInt(String key, int value);

  void putDouble(String key, double value);

  void putBool(String key, bool value);

  String? getString(String key, {String? defaultValue});

  int? getInt(String key, {int? defaultValue});

  double? getDouble(String key, {double? defaultValue});

  bool getBool(String key, {bool defaultValue = false});

  Future<bool> removeKey(String key);

  Future<bool> clear();
}