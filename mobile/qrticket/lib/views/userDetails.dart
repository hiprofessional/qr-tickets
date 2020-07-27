import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrticket/qrcode_reader.dart';
import 'package:qrticket/model/user.dart';
import 'package:qrticket/services/login.service.dart';
import 'package:qrticket/services/ticket.service.dart';
import 'package:qrticket/services/user.service.dart';

class UserDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserDetailsState();
  }
}

class UserDetailsState extends State<UserDetails> {
  var loginService = LoginService();
  var userService = UserService();
  var ticketService = TicketService();

  User currentUser = User(
    email: 'test@email.com',
    name: 'John Smit',
    id: 0,
    ticket: Ticket(id: 0, image: ''),
  );

  @override
  Widget build(BuildContext context) {
    final createTicketButton = RaisedButton(
      child: Container(
        width: double.infinity,
        child: Center(child: Text('Create ticket')),
      ),
      onPressed: () {
        createTicket();
      },
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
    );
    final spacing = SizedBox(
      height: 16,
    );

    final scanQr = RaisedButton(
      onPressed: () {
        scanAndFind();
      },
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text('Scan QR'),
        ),
      ),
      color: Colors.red,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.currentUser.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(this.currentUser.email),
                spacing,
                Text(
                  'My ticket',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                spacing,
                if (currentUser.ticket.id != 0)
                  Image.memory(base64Decode(currentUser.ticket.image)),
                if (currentUser.ticket.id == 0) createTicketButton,
                spacing,
                scanQr,
              ],
            ),
          ),
        ),
      ),
    );
  }

  logout() {
    loginService.logout();
    redirectToLogin();
  }

  createTicket() {
    ticketService.createTicket().then((value) {
      setState(() {
        currentUser.ticket = value;
      });
    });
  }

  scanAndFind() {
    Future<String> futureString = new QRCodeReader()
        .setAutoFocusIntervalInMs(200) // default 5000
        .setForceAutoFocus(true) // default false
        .setTorchEnabled(true) // default false
        .setHandlePermissions(true) // default true
        .setExecuteAfterPermissionGranted(true) // default true
        .setFrontCamera(false) // default false
        .scan()
        .then((value) {
      print(value);
      userService.searchUserAndTicket(value).then((data) {
        print(data);
        if (data) {
          redirectToQrSuccess();
        } else {
          redirectToQrError();
        }
      });
    });
  }

  redirectToQrSuccess() {
    Navigator.pushNamed(context, '/qrsearch/success');
  }

  redirectToQrError() {
    Navigator.pushNamed(context, '/qrsearch/error');
  }

  loadData() async {
    if (await loginService.isLoggedIn()) {
      var userData = await loginService.getCurrentUserData();
      if (userData != null) {
        var u = await userService.getUserById(userData.userId);
        if (u != null) {
          setState(() {
            this.currentUser = u;
          });
        } else {
          redirectToLogin();
        }
      }
    } else {
      redirectToLogin();
    }
  }

  redirectToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }
}
