import 'package:codingstack_core/src/constants/lottie_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../codingstack_core_network.dart';
import 'viewmodel_provider.dart';

class ViewModelConsumer<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget child;
  final String? errorUrl;

  const ViewModelConsumer({
    Key? key,
    required this.viewModel,
    required this.child,
    this.errorUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: viewModel,
      child: Stack(
        children: [
          Obx(
            () => viewModel.error.value != null
                ? ErrorPage(
                    title: viewModel.error.value?.code.toString() ?? 'Ops!',
                    message: viewModel.error.value!.readableError,
                    lottieUrl: errorUrl ?? kErrorLottieCore)
                : child,
          ),
          Obx(
            () => Visibility(
              visible: viewModel.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
