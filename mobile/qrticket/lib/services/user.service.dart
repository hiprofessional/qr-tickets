import 'dart:convert';

import 'package:qrticket/services/jwt.dart';
import 'package:http/http.dart' as http;

import 'package:qrticket/environment.dart';
import 'package:qrticket/model/user.dart';

class UserService {
  var jwtHelper = JwtHelper();

  Future<User> getUserById(int userId) async {
    var token = await jwtHelper.getJwtOrEmpty();

    return http.get(
      Environment().apiUrl + 'users/' + userId.toString(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    ).then((value) {
      var json = jsonDecode(utf8.decode(value.bodyBytes));

      if (json.containsKey('error')) {
        return null;
      }

      return User.fromJson(json);
    });
  }

  Future<bool> searchUserAndTicket(String key) async {
    var token = await jwtHelper.getJwtOrEmpty();

    var userId = '0';
    var ticketId = '0';

    // UserId=1;TicketId=3
    key.split(';').forEach((element) {
      var currentKeyValue = element.split('=');

      if (currentKeyValue[0] == 'UserId') {
        userId = currentKeyValue[1];
      }

      if (currentKeyValue[0] == 'TicketId') {
        ticketId = currentKeyValue[1];
      }
    });
    print(Environment().apiUrl + 'search?UserId=$userId&TicketId=$ticketId');
    return http.get(
      Environment().apiUrl + 'search?UserId=$userId&TicketId=$ticketId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    ).then((value) {
      print('search:');
      print(value.statusCode);
      if (value.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }
}
