import 'package:nyxx/nyxx.dart';
import 'credentials.dart';
import 'utils/sendEmail.dart';
import 'utils/feedbackBuilder.dart';
import 'utils/whitelist.dart';

void main() {
  final bot = Nyxx(BOT_TOKEN, GatewayIntents.allUnprivileged);

  bot.onMessageReceived.listen((event) async {
    if (event.message.content == ".ping") {
      event.message.channel.sendMessage(MessageBuilder.content("Pong!"));
      event.message.createReaction(UnicodeEmoji("✅"));
    }
    if (event.message.content.startsWith("[foxynreg]") &&
        event.message.channel.id == REG_CHANNEL_ID) {
      event.message
          .createReaction(UnicodeEmoji("✅"))
          .then((value) => (event.message.createReaction(UnicodeEmoji("❌"))));
    }
  });

  bot.onMessageReactionAdded.listen((event) {
    if ((event.emoji.formatForMessage() == "✅" ||
            event.emoji.formatForMessage() == "❌") &&
        event.channel.id == REG_CHANNEL_ID &&
        event.user.hashCode != 877205534766419968) {
      bool approve = event.emoji.formatForMessage() == "✅";
      print(approve ? "Approved registration." : "Denied registration.");

      String email = event.message!.content
          .split("\n")
          .firstWhere((element) => element.startsWith("email:"))
          .split("email:")[1];
      String playername = event.message!.content
          .split("\n")
          .firstWhere((element) => element.startsWith("playername:"))
          .split("playername:")[1];
      List<String> formChoices = event.message!.content
          .split("\n")
          .firstWhere((element) => element.startsWith("formChoices:"))
          .split("formChoices:")[1]
          .split(" ");

      print("email: $email, playername: $playername");
      sendMail(approve, email, playername, feedbackBuilder(formChoices));

      if (approve) {
        addToWhitelists(playername);
        bot.fetchChannel<TextChannel>(ANNOUNCE_CHANNEL_ID.toSnowflake()).then(
            (value) => value.sendMessage(MessageBuilder.content(
                "👋 **${playername}** regisztrációját elfogadtuk.")));
      }

      event.message!.createReaction(UnicodeEmoji("🆗"));
    }
  });
}
