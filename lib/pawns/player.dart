import 'package:flame/components.dart';
import 'package:flame_game_playground/game/space_shooter_game.dart';
import 'package:flame_game_playground/pawns/bullet.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Player() : super(size: Vector2(50, 50), anchor: Anchor.center);

  late final SpawnComponent _bulletSpawner1;
  late final SpawnComponent _bulletSpawner2;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    _bulletSpawner1 = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) => Bullet(
        position: position + Vector2(14, -height / 2),
      ),
      autoStart: false,
    );
    _bulletSpawner2 = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) => Bullet(
        position: position + Vector2(-14, -height / 2),
      ),
      autoStart: false,
    );

    game.add(_bulletSpawner1);
    game.add(_bulletSpawner2);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner1.timer.start();
    _bulletSpawner2.timer.start();
  }

  void stopShooting() {
    _bulletSpawner1.timer.stop();
    _bulletSpawner2.timer.stop();
  }
}
