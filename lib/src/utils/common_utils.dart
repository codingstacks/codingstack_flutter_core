extension MapExt on Map<String, dynamic> {
  String? getValidationError({required String key}) {
    return containsKey(key) ? this[key][0] : null;
  }

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      this[key] = value;
    }
  }
}


