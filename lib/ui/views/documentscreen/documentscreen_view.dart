import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_docs/app/app.router.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/ui/common/app_colors.dart';
import 'package:google_docs/ui/widgets/common/loader/loader.dart';
import 'package:stacked/stacked.dart';

import 'documentscreen_viewmodel.dart';

class DocumentscreenView extends StackedView<DocumentscreenViewModel> {
  final DocumentModel document;
  const DocumentscreenView({Key? key, required this.document})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DocumentscreenViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.quillController == null) {
      return const Scaffold(
        body: Loader(),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  viewModel.autoSaveTimer.cancel();
                  viewModel.navigationService.navigateToHomescreenView();
                }),
            backgroundColor: kWhiteColor,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.lock,
                    size: 16,
                    color: kWhiteColor,
                  ),
                  label: const Text(
                    'Share',
                    style: TextStyle(color: kWhiteColor),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
                ),
              )
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/docs-logo.png',
                    height: 40,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: viewModel.titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kBlueColor, width: 0.1),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      onSubmitted: (value) =>
                          viewModel.updateTitle(document.id, value),
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: kGreyColor)),
              ),
            ),
          ),
          body: Center(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: viewModel.quillController!,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('en'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  width: 750,
                  child: Card(
                    color: kWhiteColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: viewModel.quillController!,
                          readOnly: false,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('en'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ));
    }
  }

  @override
  DocumentscreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DocumentscreenViewModel(document: document);
}
