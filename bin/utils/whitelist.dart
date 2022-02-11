import 'uuid.dart';
import 'dart:io';
import '../credentials.dart';
//import 'package:source_server/source_server.dart';

File survivalWhitelist = File(SURVIVAL_WHITELIST_PATH);
File moddedWhitelist = File(MODDED_WHITELIST_PATH);

void addToWhitelists(String playername) {
  
  List<String> whiteListLines = survivalWhitelist.readAsLinesSync();
  whiteListLines.removeLast();
  whiteListLines[whiteListLines.length - 1] += ",";
  whiteListLines.addAll([
    '  {',
    '    "uuid": "${getUUID(playername)}",',
    '    "name": "${playername}"',
    '  }',
    ']'
  ]);

  String whiteListString = whiteListLines.join("\n");

  survivalWhitelist
      .writeAsString(whiteListString)
      .then((value) => print("Succesfully wrote to survival whitelist."));
  moddedWhitelist
      .writeAsString(whiteListString)
      .then((value) => print("Succesfully wrote to modded whitelist."));

  /*//! RCON
  SourceServer survival = SourceServer(RCON_PSWD, port: RCON_SURVIVAL);
  SourceServer modded = SourceServer(RCON_PSWD, port: RCON_MODDED);

  survival.connect().then((value) => {
        survival.command("whitelist add ${playername}").then(
            (value) => {print("Added $playername to survival whitelist.")})
      });
  modded.connect().then((value) => {
        modded.command("whitelist add ${playername}").then(
            (value) => {print("Added $playername to survival whitelist.")})
      });*/
}
