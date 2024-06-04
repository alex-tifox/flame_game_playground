import 'package:flame/game.dart';
import 'package:flame_game_playground/game/space_shooter_game.dart';
import 'package:flutter/widgets.dart';

void main() {
  final game = SpaceShooterGame();
  runApp(GameWidget(game: game));
}
