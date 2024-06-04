import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_game_playground/pawns/enemy.dart';
import 'package:flame_game_playground/pawns/player.dart';
import 'package:flutter/rendering.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
        ParallaxImageData('stars_0.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );

    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (_) => Enemy(),
        period: .3,
        // Spawning enemy in the area without enemy passing beyond scene edges
        area: Rectangle.fromLTWH(Enemy.enemySize / 2, 0,
            size.x - (Enemy.enemySize), -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}
