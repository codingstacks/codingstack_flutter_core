class Resource<T> {
  final Status status;
  final T? data;
  final ErrorResource? error;

  Resource._(this.status, {this.data, this.error});

  static Resource<T> failure<T>(String error, {int code = -1, Map<String,dynamic>? validationError}) {
    return Resource._(Status.failure, error: ErrorResource(
      errorMessage: error,
      code: code,
      validationError: validationError,
    ));
  }
  static Resource<T> success<T>(T? data) {
    return Resource._(Status.success, data:data);
  }

  @override
  String toString() {
    return 'Status : $status \n Data: $data \n Error: ${error?.errorMessage}';
  }
}

enum Status {
  success, failure
}

class ErrorResource {
  String? errorMessage;
  int code;
  Map<String, dynamic>? validationError;

  ErrorResource({this.errorMessage, this.code = -1, this.validationError});

  String get readableError => errorMessage ?? 'Something went Wrong';
}

