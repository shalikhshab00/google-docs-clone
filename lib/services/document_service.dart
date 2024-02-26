import 'dart:convert';

import 'package:google_docs/app/app.logger.dart';
import 'package:google_docs/constants.dart';
import 'package:google_docs/models/document_model.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:http/http.dart';

class DocumentService {
  final Client client = Client();
  final logger = getLogger('GoogleService');

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured.', data: null);
    try {
      var res = await client.post(
        Uri.parse('$host/doc/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          },
        ),
      );
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          error = ErrorModel(error: res.body, data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel?> getDocument(String token) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured.', data: null);
    try {
      var res = await client.get(
        Uri.parse('$host/docs/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      switch (res.statusCode) {
        case 200:
          List<DocumentModel> documents = <DocumentModel>[];
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            documents.add(
              DocumentModel.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
          error = ErrorModel(
            error: null,
            data: documents,
          );
          break;
        default:
          error = ErrorModel(error: res.body, data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel?> getDocumentById(
      {required String token, required String id}) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured.', data: null);
    try {
      var res = await client.get(
        Uri.parse('$host/docs/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          throw 'This Document does not exist, please create a new one.';
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> updateDocument(
      {required String token,
      required String id,
      required String title}) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured.', data: null);
    try {
      var res = await client.post(
        Uri.parse('$host/doc/title'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {'id': id, 'title': title},
        ),
      );
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          error = ErrorModel(error: res.body, data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
