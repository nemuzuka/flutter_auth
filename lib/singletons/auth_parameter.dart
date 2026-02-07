class AuthParameter {
  static final AuthParameter _instance = AuthParameter._internal();
  static const String authorizationEndpoint = 'https://example.com/oauth/authorize';

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
    return authorizationEndpoint;
  }
}
