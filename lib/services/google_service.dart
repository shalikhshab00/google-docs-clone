import 'dart:convert';

import 'package:google_docs/app/app.logger.dart';
import 'package:google_docs/constants.dart';
import 'package:google_docs/models/error_model.dart';
import 'package:google_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class GoogleService {
  final Client client = Client();
  final logger = getLogger('GoogleService');

  final GoogleSignIn _googleSignin = GoogleSignIn();

  Future<ErrorModel?> signInWithGoogle() async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      final user = await _googleSignin.signIn();
      if (user != null) {
        final userAcc = UserModel(
            email: user.email,
            name: user.displayName!,
            profilePic: user.photoUrl!,
            uid: '',
            token: '');

        var res = await client.post(
          Uri.parse('$host/api/signup'),
          body: userAcc.toJson(),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
                uid: jsonDecode(res.body)['user']['_id'],
                token: jsonDecode(res.body)['token']);
            error = ErrorModel(error: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel?> getUserData(String? token) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occured', data: null);
    try {
      if (token != null) {
        var res = await client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });

        switch (res.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(
              jsonEncode(jsonDecode(res.body)['user']),
            ).copyWith(token: token);
            error = ErrorModel(error: null, data: newUser);
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<void> signOut() async {
    await _googleSignin.signOut();
  }
}
