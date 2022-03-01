import 'package:dio/dio.dart';

import 'parser.dart';

abstract class BaseApiService {
  Parser<T> provideParser<T>();
}