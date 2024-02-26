import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'loader_model.dart';

class Loader extends StackedView<LoaderModel> {
  const Loader({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoaderModel viewModel,
    Widget? child,
  ) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  LoaderModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoaderModel();
}
