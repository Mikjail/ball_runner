import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/ball_runner.dart';

void main() {
  testWidgets('''
Given the ball runner
WHEN the Game is started
THEN the BallRunner Gamse is loaded
''', (tester) async {
    final game = BallRunner();
    final widget = GameWidget(game: game);
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();

    expect(find.byType(GameWidget<BallRunner>), findsOneWidget);
  });
}
