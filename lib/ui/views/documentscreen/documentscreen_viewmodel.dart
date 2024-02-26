import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_docs/app/app.locator.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/services/document_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DocumentscreenViewModel extends BaseViewModel {
  DocumentscreenViewModel({required this.document}) {
    initData();
    fetchDocumentData();
  }

  DocumentModel document;
  final documentService = locator<DocumentService>();
  final navigationService = locator<NavigationService>();
  final quill.QuillController quillController = quill.QuillController.basic();
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');

  String token = '';

  void initData() async {
    token = (await getToken())!;
    titleController.text = document.title;
  }

  void fetchDocumentData() async {
    await documentService.getDocumentById(token: token, id: document.id);
    rebuildUi();
  }

  Future updateTitle(String id, String title) async {
    await documentService.updateDocument(token: token, id: id, title: title);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }
}
