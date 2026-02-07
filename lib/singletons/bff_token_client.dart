import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_parameter.dart';

class BffTokenClient {
  static final BffTokenClient _instance = BffTokenClient._internal();
  static const String tokenEndpoint = 'http://10.0.2.2:3000/oauth/token';

  BffTokenClient._internal();

  factory BffTokenClient() {
    return _instance;
  }

  Future<String> fetchData(String code) async {
    final response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'code': code,
        'state': AuthParameter().state,
        'nonce': AuthParameter().nonce,
      }),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)["bffToken"];
      const storage = FlutterSecureStorage();
      await storage.write(key: 'bff_token', value: token);
      return token;
    } else {
      throw Exception('Failed to call api.');
    }
  }
}
