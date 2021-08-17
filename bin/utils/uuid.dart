import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

String getUUID(String name) {
  //Get a byte list from the hash of the username
  Uint8List hash = Uint8List.fromList(
      md5.convert(utf8.encode("OfflinePlayer:" + name)).bytes);

  //Set bytes to indicate:
  //Version 3: name based md5hash
  hash[6] = hash[6] & 0x0f | 0x30;
  //IETF variant
  hash[8] = hash[8] & 0x3f | 0x80;

  var uid = "";
  var dashes = [4, 6, 8, 10];

  //Get hex string from byte list, and include dashes to get final formatting
  for (var i = 0; i < hash.length; i += 2) {
    int sec = 0;
    if (i + 1 < hash.length) {
      sec = hash[i + 1];
    }
    if (dashes.contains(i)) {
      uid += "-";
    }
    uid += ((hash[i] << 8) | sec).toRadixString(16);
  }

  return (uid);
}
