extension StringExt on String {

  String addPath(String path) => Uri(host: this, path: path).toString().replaceFirst('/', '');
}