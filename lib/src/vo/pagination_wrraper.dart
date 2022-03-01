import 'api_response.dart';

class PaginationData<T> {
  final List<T> data;
  final Meta meta;

  PaginationData(this.data, this.meta);
}