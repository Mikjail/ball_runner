import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_runner_game/ball_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(
    const GameWidget<BallRunner>.controlled(
      gameFactory: BallRunner.new,
    ),
  );
}
