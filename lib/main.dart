import 'package:flame/game.dart';
import 'package:flame_workshop/gdsc_game.dart';
import 'package:flutter/material.dart';

void main() {
  GDSCGame game = GDSCGame();

  runApp(GameWidget(game: game));
}
