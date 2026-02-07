import 'package:flutter_auth/singletons/random_string_generator.dart';

class AuthParameter {
  static final AuthParameter _instance = AuthParameter._internal();
  // エミュレータから localhost に接続する場合は 10.0.2.2 にする
  static const String authorizationEndpoint = 'http://10.0.2.2:3000/oauth/authorize';

  AuthParameter._internal();

  factory AuthParameter() {
    return _instance;
  }

  // プロパティ
  String state = '';
  String nonce = '';
  String codeChallenge = '';
  String codeVerifier = '';

  String buildAuthorizationEndpointUri() {
    state = RandomStringGenerator().generateString();
    nonce = RandomStringGenerator().generateString();
    return '$authorizationEndpoint?state=$state&nonce=$nonce';
  }
}
