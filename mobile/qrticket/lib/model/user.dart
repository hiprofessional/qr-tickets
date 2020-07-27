class SignUpUser {
  String name;
  String email;
  String password;

  SignUpUser({this.name, this.email, this.password});
}

class LoginUser {
  String email;
  String password;

  LoginUser({this.email, this.password});
}

class TokenData {
  bool authorized;
  int userId;
  String userName;
  String email;
  int exp;

  TokenData.decode(Map<String, dynamic> data)
      : authorized = data['authorized'],
        userId = data['userId'],
        userName = data['userName'],
        email = data['email'],
        exp = data['exp'];
}

class User {
  String name;
  String email;
  int id;

  Ticket ticket;

  User({this.id, this.email, this.name, this.ticket});

  User.fromJson(Map<String, dynamic> json)
      : email = json['Email'],
        name = json['Name'],
        id = json['Id'],
        ticket = Ticket.fromJson(json['Ticket']);
}

class Ticket {
  int id;
  String image;

  Ticket({this.id, this.image});

  Ticket.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        image = json['Image'];
}
