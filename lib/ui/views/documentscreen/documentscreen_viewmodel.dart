import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';
import 'package:google_docs/app/app.locator.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/services/document_service.dart';
import 'package:google_docs/services/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DocumentscreenViewModel extends BaseViewModel {
  DocumentscreenViewModel({required this.document}) {
    initData();
    socketService.joinRoom(document.id);
    socketService.changeListener((data) => {
          quillController?.compose(
              Delta.fromJson(data['delta']),
              quillController?.selection ??
                  const TextSelection.collapsed(offset: 0),
              quill.ChangeSource.remote)
        });
    autoSaveTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!isSaving) {
        isSaving = true;
        socketService.autoSave(<String, dynamic>{
          'delta': quillController!.document.toDelta(),
          'room': document.id,
          'version': document.version
        });
        isSaving = false;
        rebuildUi();
      }
    });
  }

  DocumentModel document;
  final documentService = locator<DocumentService>();
  final navigationService = locator<NavigationService>();
  final socketService = locator<SocketService>();
  quill.QuillController? quillController = quill.QuillController.basic();
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  String token = '';
  bool isSaving = false;
  late Timer autoSaveTimer;

  void initData() async {
    token = (await getToken())!;
    titleController.text = document.title;
    fetchDocumentData();
  }

  void fetchDocumentData() async {
    var resp =
        await documentService.getDocumentById(token: token, id: document.id);
    quillController = quill.QuillController(
        document: resp!.data.content.isEmpty
            ? quill.Document()
            : quill.Document.fromDelta(Delta.fromJson(resp.data.content)),
        selection: const TextSelection.collapsed(offset: 0));

    quillController!.document.changes.listen((event) {
      if (event.source == quill.ChangeSource.local) {
        Map<String, dynamic> map = {
          'delta': event.change,
          "room": document.id,
          "version": document.version
        };
        socketService.typing(map);
      }
    });
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
