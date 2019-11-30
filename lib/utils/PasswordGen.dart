import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
//USING HMAC-SHA256
String genPasswordHMAC({@required String rawPassword,@required String mixed}){
  var KEY = utf8.encode(rawPassword);
  var bytes = utf8.encode(mixed);

  var hmacedPassword = Hmac(sha512, KEY);
  var digest = hmacedPassword.convert(bytes);
  return '$digest';
}