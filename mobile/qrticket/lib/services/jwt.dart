import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qrticket/model/user.dart';

class JwtHelper {
  var storage = FlutterSecureStorage();

  setJwt(String value) async {
    await storage.write(key: 'jwt', value: value);
  }

  Future<String> getJwtOrEmpty() async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null) return '';
    return jwt;
  }

  removeJwt() async {
    storage.delete(key: 'jwt');
  }

  Future<bool> isTokenExpired() async {
    var token = await getJwtOrEmpty();
    if (token.isNotEmpty) {
      return JwtDecoder.isExpired(token);
    }

    return true;
  }

  Future<TokenData> getCurrentTokenData() async {
    var token = await getJwtOrEmpty();
    if (token.isNotEmpty) {
      var decoded = JwtDecoder.decode(token);
      TokenData td = TokenData.decode(decoded);
      return td;
    }
  }
}
