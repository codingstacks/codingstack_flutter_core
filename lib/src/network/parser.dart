abstract class Parser<T> {

  T? parse(Map<String, dynamic> response);

  bool isSubtype<T1, T2>() => <T1>[] is List<T2>;

}