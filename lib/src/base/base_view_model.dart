import 'package:codingstack_core/src/vo/resource.dart';
import 'package:get/get.dart';

abstract class BaseViewModel extends GetxController {

  final isLoading = false.obs;
  final isPaginationLoading = false.obs;
  final error = Rx<ErrorResource?>(null);

  void notifyLoader(bool isLoading, {bool paginate = false}) {
    if (paginate) {
      isPaginationLoading.value = paginate;
    }
    else {
      this.isLoading.value = isLoading;
    }
  }

  void notifyError(ErrorResource? resource) {
    error.value = resource;
  }
}