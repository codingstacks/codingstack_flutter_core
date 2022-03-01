import 'package:flutter/cupertino.dart';

import '../base/base_view_model.dart';

class ViewModelProvider<ViewModel extends BaseViewModel>
    extends InheritedWidget {
  final ViewModel viewModel;

  const ViewModelProvider(
      {required Widget child, required this.viewModel, Key? key})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static ViewModelProvider<T> of<T extends BaseViewModel>(
          BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ViewModelProvider<T>>()!;
}
