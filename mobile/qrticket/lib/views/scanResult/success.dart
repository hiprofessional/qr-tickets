import 'package:flutter/material.dart';

class QrSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.green.shade100,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.check, size: 145, color: Colors.green.shade900),
                    Text('Ticket is valid',
                        style: TextStyle(
                            fontSize: 45, color: Colors.green.shade900))
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              RaisedButton(
                child: Container(
                  width: double.infinity,
                  child: Center(child: Text('Got it!')),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.green.shade400,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
