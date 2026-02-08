import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoClient {
  static final UserInfoClient _instance = UserInfoClient._internal();
  static const String endpoint = 'http://10.0.2.2:3000/api/user-info';

  UserInfoClient._internal();

  factory UserInfoClient() {
    return _instance;
  }

  Future<String> fetchData() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'bff_token');
    if (token == null) {
      throw Exception('Failed to call api 401.');
    }

    final response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final username = jsonDecode(response.body)["username"];
      return username;
    } else if (response.statusCode == 401) {
      await storage.delete(key: 'bff_token');
      throw Exception('Failed to call api 401.');
    } else {
      throw Exception('Failed to call api.');
    }
  }
}
