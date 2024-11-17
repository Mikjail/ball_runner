import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_runner_game/ball_runner.dart';

void main() {
  runApp(
    const GameWidget<BallRunner>.controlled(
      gameFactory: BallRunner.new,
    ),
  );
}
