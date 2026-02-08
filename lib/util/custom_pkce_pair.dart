import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class CustomPkcePair {
  final String codeVerifier;
  final String codeChallenge;

  CustomPkcePair(this.codeVerifier, this.codeChallenge);

  factory CustomPkcePair.generate({int length = 64}) {
    const String charset =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    final Random random = Random.secure();
    final String verifier = List.generate(
      length,
      (i) => charset[random.nextInt(charset.length)],
    ).join();

    final bytes = utf8.encode(verifier);
    final digest = sha256.convert(bytes);
    final challenge = base64Url.encode(digest.bytes).replaceAll('=', '');

    return CustomPkcePair(verifier, challenge);
  }
}
