import 'package:google_docs/app/app.locator.dart';
import 'package:google_docs/app/app.router.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/services/document_service.dart';
import 'package:google_docs/services/google_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomescreenViewModel extends BaseViewModel {
  final googleService = locator<GoogleService>();
  final documentService = locator<DocumentService>();
  final navigationService = NavigationService();
  final dialogService = locator<DialogService>();
  List<DocumentModel> documents = <DocumentModel>[];

  String? token = '';

  HomescreenViewModel() {
    initData();
  }

  Future<void> signOut() async {
    await googleService.signOut();
    setToken('');
    await navigationService.navigateToLoginView();
  }

  void initData() async {
    token = await getToken();
    await getDocuments();
    rebuildUi();
  }

  Future getDocuments() async {
    setBusy(true);
    var resp = await documentService.getDocument(token!);
    documents = resp!.data;
    rebuildUi();
    setBusy(false);
  }

  void createDocument() async {
    var resp = await documentService.createDocument(token!);
    if (resp.data != null) {
      await navigationService.navigateToDocumentscreenView(document: resp.data);
    } else {
      await dialogService.showDialog(title: 'Error');
    }
  }

  void navigateToDocument(DocumentModel document) async {
    await navigationService.navigateToDocumentscreenView(document: document);
  }

  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }
}
