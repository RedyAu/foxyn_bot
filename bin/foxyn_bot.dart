import 'package:nyxx/nyxx.dart';

import 'credentials.dart';
import 'utils/uuid.dart';

void main() {
  final bot = Nyxx(BOT_TOKEN, GatewayIntents.allUnprivileged);

  bot.onMessageReceived.listen((event) {
    if (event.message.content == ".ping") {
      event.message.channel.sendMessage(MessageBuilder.content("Pong!"));
    }
  });
}
