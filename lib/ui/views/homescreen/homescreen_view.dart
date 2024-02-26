import 'package:flutter/material.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/ui/common/app_colors.dart';
import 'package:google_docs/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';

import 'homescreen_viewmodel.dart';

class HomescreenView extends StackedView<HomescreenViewModel> {
  const HomescreenView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomescreenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          actions: [
            IconButton(
              onPressed: () => viewModel.createDocument(),
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () => viewModel.signOut(),
              icon: const Icon(
                Icons.logout,
                color: kcRedColor,
              ),
            ),
          ],
        ),
        body: viewModel.isBusy
            ? const Loader()
            : Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 400,
                  child: ListView.builder(
                    itemCount: viewModel.documents.length,
                    itemBuilder: (context, index) {
                      DocumentModel document = viewModel.documents[index];

                      return InkWell(
                        onTap: () => viewModel.navigateToDocument(document),
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Center(
                              child: Text(
                                document.title,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }

  @override
  HomescreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomescreenViewModel();
}
