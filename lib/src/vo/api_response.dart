class ApiResponse<T> {
  final bool success;
  final String? errorMessage;
  final int code;
  final T? data;
  final Map<String, dynamic>? validationError;
  final Meta? meta;

  ApiResponse({
    required this.success,
    this.errorMessage,
    required this.code,
    this.data,
    this.validationError,
    this.meta,
  });
}

class Meta {
  final Pagination? pagination;

  Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> map) {
    return Meta(pagination: Pagination.fromJson(map['pagination']));
  }
}

class Pagination {
  final int perPage;
  final int totalPage;
  final int currentPage;
  final String? nextUrl;

  Pagination({
    required this.perPage,
    required this.totalPage,
    required this.currentPage,
    this.nextUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> map) {
    return Pagination(
      perPage: map['per_page'],
      totalPage: map['total_page'],
      currentPage: map['current_page'],
      nextUrl: map['next_page_url']
    );
  }
}
