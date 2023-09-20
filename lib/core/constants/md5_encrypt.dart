import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import '../../view/widgets/snack.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

void checkInternet(Function() function) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      function();
    }
  } on SocketException catch (_) {
    Snack().show(type: false, message: 'لا يوجد اتصال بالانترنت');
  }
}
