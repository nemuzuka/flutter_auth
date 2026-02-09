import 'package:flutter_auth/singletons/random_string_generator.dart';

import '../util/custom_pkce_pair.dart';

class AuthParameter {
  static final AuthParameter _instance = AuthParameter._internal();
  // エミュレータから localhost に接続する場合は 10.0.2.2 にする
  static const String authorizationEndpoint =
      'http://10.0.2.2:18080/corporate_code_001/tenant_code_001/oauth/authorize';

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
    final pkcePair = CustomPkcePair.generate();
    codeVerifier = pkcePair.codeVerifier;
    codeChallenge = pkcePair.codeChallenge;
    final parameter = '?state=$state&nonce=$nonce&code_challenge=$codeChallenge'
      '&client_id=client_004&response_type=code&response_mode=query'
      '&redirect_uri=myapp%3A%2F%2Fnet.jp.vss.flutter-auth%2Fauth-callback'
      '&scope=openid+offline_access+email&code_challenge_method=S256';
    return '$authorizationEndpoint$parameter';
  }
}
