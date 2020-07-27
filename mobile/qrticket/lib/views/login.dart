import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrticket/model/user.dart';
import 'package:qrticket/services/login.service.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  LoginUser user = LoginUser();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      onSaved: (String value) => {user.email = value},
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
      validator: (value) {
        return requiredValidator(value);
      },
    );
    final passwordField = TextFormField(
      onSaved: (String value) => {user.password = value},
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        return requiredValidator(value);
      },
    );

    final signInButton = RaisedButton(
      child: Container(
        width: double.infinity,
        child: Center(child: Text('Sign in')),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          signIn(this.user);
        }
      },
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      color: Colors.blue,
      textColor: Colors.white,
    );

    final redirectToSignUpButton = FlatButton(
      onPressed: () {
        redirectToSignUn();
      },
      child: Text(
        'Sign up',
        style: TextStyle(color: Colors.blue),
      ),
    );

    final spacing = SizedBox(
      height: 16,
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                spacing,
                Text('Welcome back'),
                Text('Sign in to continue work with QR app'),
                spacing,
                emailField,
                spacing,
                passwordField,
                spacing,
                signInButton,
                spacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account?'),
                    redirectToSignUpButton,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  requiredValidator(value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  signIn(LoginUser loginUser) async {
    print(loginUser);
    var loginService = LoginService();
    var response = await loginService.login(loginUser);
    if (response) {
      redirectToUserPage();
    }
  }

  redirectToSignUn() {
    Navigator.pushNamed(context, '/signup');
  }

  redirectToUserPage() {
    Navigator.pushNamedAndRemoveUntil(context, '/user', (route) => false);
  }
}
