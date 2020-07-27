import 'dart:convert';

import 'package:qrticket/environment.dart';
import 'package:qrticket/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:qrticket/services/jwt.dart';

class LoginService {
  var jwtHelper = JwtHelper();

  Future<bool> login(LoginUser loginUser) async {
    return http
        .post(
      Environment().apiUrl + 'login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': loginUser.email,
        'Password': loginUser.password,
      }),
    )
        .then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        var token = jsonDecode(utf8.decode(value.bodyBytes));
        jwtHelper.setJwt(token);
        return true;
      } else {
        return false;
      }
    });
  }

  logout() {
    jwtHelper.removeJwt();
  }

  Future<bool> isLoggedIn() async {
    var td = await jwtHelper.isTokenExpired();
    return !td;
  }

  Future<TokenData> getCurrentUserData() async {
    var td = await jwtHelper.getCurrentTokenData();
    return td;
  }
}
