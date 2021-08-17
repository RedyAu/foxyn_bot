import '../credentials.dart';

import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Test mailer by sending email to yourself
void sendMail(bool approve, String emailAddress, String playerName,
    String feedback) async {
  final smtpServer = gmail(GOOGLE_USERNAME, GOOGLE_APP_PSWD);

  Iterable<Address> toAd(Iterable<String>? addresses) =>
      (addresses ?? []).map((a) => Address(a));

  Iterable<Attachment> toAt(Iterable<String>? attachments) =>
      (attachments ?? []).map((a) => FileAttachment(File(a)));

  // Create our message.
  final message = Message()
    ..from = Address('$GOOGLE_USERNAME@gmail.com', 'Foxyn Regisztráció')
    ..subject = approve ? 'Üdv a Foxynon!' : 'Regisztrációd elutasítottuk.'
    ..recipients.addAll(toAd([emailAddress]))
    ..text = approve
        ? 'Szia $playerName!\nElfogadtuk a Foxyn regisztrációdat.\n\nA belépésről továbbiakat a Discord szerverünkön olvashatsz, csatlakozz: https://discord.gg/CuExeek\n\nVisszajelzés a regisztrációs íven megadottakhoz:\n${feedback}Várunk a szerveren!'
        : 'Szia $playerName!\n\nFoxyn regisztrációdat sajnos elutasítottuk.\nDöntésünk végleges, kérünk, ne próbálozz újból a regisztrációval.';

  try {
    final sendReport =
        await send(message, smtpServer, timeout: Duration(seconds: 15));
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
