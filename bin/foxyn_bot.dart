import 'package:nyxx/nyxx.dart';

import 'credentials.dart';
import 'utils/uuid.dart';

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
    if (event.emoji.formatForMessage() == "✅" &&
        event.channel.id == REG_CHANNEL_ID &&
        event.user.hashCode != bot.self.id) {
      print("approved registration.");

      String email = event.message!.content
          .split("\n")
          .firstWhere((element) => element.startsWith("email:"))
          .split("email:")[1];
      String playername = event.message!.content
          .split("\n")
          .firstWhere((element) => element.startsWith("playername:"))
          .split("playername:")[1];

      print("email: $email, playername: $playername");

      event.message!.createReaction(UnicodeEmoji("🆗"));
    }
  });
}
