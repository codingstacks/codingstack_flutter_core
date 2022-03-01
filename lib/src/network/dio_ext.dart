import 'package:codingstack_core/src/vo/api_response.dart';
import 'package:dio/dio.dart';

import 'api_service.dart';

extension DioExt on Future<Response<dynamic>> {
  Future<ApiResponse<T>> safeApiCall<T>(BaseApiService apiService) async {
    try {
      final response = await this;
      int statusCode = response.statusCode ?? -1;
      if (statusCode >= 200 && statusCode <= 300) {

        if (statusCode == 204) {
          //No Content
          return ApiResponse(
              success: true,
              code: statusCode,
              data: null);
        }
        final hasMeta = response.data['data'].containsKey('meta');

        return ApiResponse(
            success: true,
            code: statusCode,
            data: apiService.provideParser<T>().parse(response.data),
            meta:  hasMeta ? Meta.fromJson(response.data['data']['meta']) : null,
        );
      } else {
        return ApiResponse(
            success: false,
            code: statusCode,
            errorMessage: response.data ?? 'Error');
      }
    } catch (e,s) {
      print(s);
      if (e is DioError) {
        return handleDioError(e);
      }
      return ApiResponse<T>(success: false, code: -1, errorMessage: '$e');
    }
  }
}

ApiResponse<T> handleDioError<T>(DioError e) {
  switch (e.type) {
    case DioErrorType.connectTimeout:
      return ApiResponse<T>(success: false, code: -1, errorMessage: e.error);
    case DioErrorType.sendTimeout:
      return ApiResponse<T>(success: false, code: -1, errorMessage: e.error);
    case DioErrorType.receiveTimeout:
      return ApiResponse<T>(success: false, code: -1, errorMessage: e.error);
    case DioErrorType.response:
      final errorBody = e.response!.data;
      try {
        return ApiResponse<T>(
          success: errorBody['status'] ?? false,
          code: e.response?.statusCode ?? errorBody['code'] ?? -1,
          errorMessage: errorBody['message'] ?? e.response?.statusMessage ?? '$e',
          validationError: errorBody['validationError'],
        );
      }
      catch(exc) {
        return ApiResponse<T>(
          success:false,
          code: e.response?.statusCode ?? -1,
          errorMessage: e.response?.data ?? 'Something went wrong',
        );
      }
    case DioErrorType.cancel:
      return ApiResponse<T>(success: false, code: -1, errorMessage: e.error);
    case DioErrorType.other:
      return ApiResponse<T>(
          success: false, code: -1, errorMessage: '${e.error}');
  }
}
