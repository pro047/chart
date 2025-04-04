import 'package:crypto/crypto.dart';
import 'dart:convert';

String convertHash(String password) {
  const uniqueKey = 'wlstjd';
  final bytes = utf8.encode(password + uniqueKey);
  final hash = sha256.convert(bytes);
  return hash.toString();
}
