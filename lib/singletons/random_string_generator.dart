import 'dart:math';

class RandomStringGenerator {
  static final RandomStringGenerator _instance = RandomStringGenerator._internal();

  RandomStringGenerator._internal();

  factory RandomStringGenerator() {
    return _instance;
  }

  String generateString([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random.secure();
    final randomStr =  List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
    return randomStr;
  }
}
