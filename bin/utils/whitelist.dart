import 'uuid.dart';
import 'dart:io';
import '../credentials.dart';

File survivalWhitelist = File(SURVIVAL_WHITELIST_PATH);
File moddedWhitelist = File(MODDED_WHITELIST_PATH);

void addToWhitelists(String playername) {
  List<String> whiteListLines = survivalWhitelist.readAsLinesSync();
  whiteListLines.removeLast();
  whiteListLines[whiteListLines.length - 1] += ",";
  whiteListLines.addAll([
    '    {',
    '        "uuid": "${getUUID(playername)}",',
    '        "name": "${playername}"',
    '    }',
    ']'
  ]);

  String whiteListString = whiteListLines.join("\n");

  survivalWhitelist.writeAsStringSync(whiteListString);
  moddedWhitelist.writeAsStringSync(whiteListString);
}
