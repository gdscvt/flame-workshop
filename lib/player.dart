import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

enum Animation { down, left, right, up }

class Player extends SpriteAnimationGroupComponent with HasGameRef {
  static final Random random = Random();

  static const Map<Animation, String> animationPaths = {
    Animation.down: 'player_walking_d.png',
    Animation.left: 'player_walking_l.png',
    Animation.right: 'player_walking_r.png',
    Animation.up: 'player_walking_u.png',
  };

  static final Map<Animation, Vector2> animationDirections = {
    Animation.down: Vector2(0, 1),
    Animation.left: Vector2(-1, 0),
    Animation.right: Vector2(1, 0),
    Animation.up: Vector2(0, -1)
  };

  static const double speed = 35;

  static const int frameCount = 3;
  static const double frameLength = 0.15;

  /// Change direction every [directionChangeCooldown] seconds
  static const double directionChangeCooldown = 3;
  double count = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Sprite size (48x48 px)
    size = Vector2.all(48.0);

    // Center player
    position = (gameRef.size - size) / 2;

    // Mapping of Animation to sprite animation data
    animations = {};

    // Fill the map
    for (Animation animation in Animation.values) {
      animations![animation] = SpriteAnimation.fromFrameData(
          await Flame.images.load(animationPaths[animation]!),
          SpriteAnimationData.sequenced(
              amount: frameCount, stepTime: frameLength, textureSize: size));
    }
  }

  @override
  void update(double dt) {
    count -= dt;

    if (count <= 0) {
      current = Animation.values[random.nextInt(Animation.values.length)];

      count = directionChangeCooldown;
    }

    Vector2 movement = animationDirections[current]! * speed * dt;

    position
      ..add(movement)
      ..clamp(Vector2.zero(), gameRef.size - size);
    super.update(dt);
  }
}
