import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrticket/model/user.dart';
import 'package:qrticket/services/signup.service.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  SignUpUser user = SignUpUser();

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
    final nameField = TextFormField(
      onSaved: (String value) => {user.name = value},
      decoration: const InputDecoration(
        hintText: 'Name',
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

    final signUpButton = RaisedButton(
      child: Container(
        width: double.infinity,
        child: Center(child: Text('Create account')),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          signUp(this.user);
        }
      },
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      color: Colors.blue,
      textColor: Colors.white,
    );

    final redirectToSignInButton = FlatButton(
      onPressed: () {
        redirectToSignIn();
      },
      child: Text(
        'Sign in',
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
                  'Create account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                spacing,
                Text('Create an account to continue work with QR ticket app'),
                spacing,
                emailField,
                spacing,
                nameField,
                spacing,
                passwordField,
                spacing,
                signUpButton,
                spacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Do you have an account?'),
                    redirectToSignInButton,
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

  signUp(SignUpUser signUpUser) async {
    var signUpService = SignUpService();
    signUpService.signUp(signUpUser).then((value) {
      redirectToSignIn();
    });
  }

  redirectToSignIn() {
    Navigator.pop(context);
  }
}
