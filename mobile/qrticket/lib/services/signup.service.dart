import 'dart:convert';

import 'package:qrticket/environment.dart';
import 'package:qrticket/model/user.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  Future<bool> signUp(SignUpUser signUpUser) async {
    return http
        .post(
      Environment().apiUrl + 'signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': signUpUser.email,
        'Password': signUpUser.password,
        'Name': signUpUser.name,
      }),
    )
        .then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }
}
