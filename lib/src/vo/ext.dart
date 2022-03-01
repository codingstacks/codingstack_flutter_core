import '../../codingstack_core_network.dart';
import 'api_response.dart';
import 'resource.dart';

extension ApiResponseExt<T> on ApiResponse<T> {

  Resource<T> get toResource {
    if (success) {
      return Resource.success<T>(data!);
    }
    else {
      return Resource.failure<T>(errorMessage!, validationError: validationError, code: code);
    }
  }
}

extension ApiResponseExtFuture<T> on Future<ApiResponse<T>> {

  Future<Resource<T>> get toResource async{
    final response = await this;
    if (response.success) {
      return Resource.success<T>(response.data);
    }
    else {
      return Resource.failure<T>(response.errorMessage!, validationError: response.validationError, code: response.code);
    }
  }

  Future<Resource<PaginationData<T>>> toResourcePaginate<T>() async{
    final response = await this;
    if (response.success) {
      return Resource.success(PaginationData<T>(response.data! as List<T>, response.meta!));
    }
    else {
      return Resource.failure(response.errorMessage!, validationError: response.validationError, code: response.code);
    }
  }
}