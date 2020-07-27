import 'dart:convert';

import 'package:qrticket/services/jwt.dart';
import 'package:http/http.dart' as http;

import 'package:qrticket/environment.dart';
import 'package:qrticket/model/user.dart';

class TicketService {
  var jwtHelper = JwtHelper();

  Future<Ticket> createTicket() async {
    var token = await jwtHelper.getJwtOrEmpty();
    var currentUser = await jwtHelper.getCurrentTokenData();
    var userId = currentUser.userId;

    return http
        .post(
      Environment().apiUrl + 'tickets',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(<String, int>{
        'UserId': userId,
        'Id': 0,
      }),
    )
        .then((value) {
      if (value.statusCode == 201) {
        var json = jsonDecode(value.body);
        return Ticket.fromJson(json);
      } else {
        return null;
      }
    });
  }
}
