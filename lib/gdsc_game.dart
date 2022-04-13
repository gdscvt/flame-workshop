import 'package:flame/game.dart';
import 'package:flame_workshop/player.dart';

class GDSCGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    Player player = Player();

    add(player);

    await super.onLoad();
  }
}
