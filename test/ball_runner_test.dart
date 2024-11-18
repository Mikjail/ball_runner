import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/ball_runner.dart';

void main() {
  testWidgets('''

Given the ball runner
WHEN the Game is started
THEN the BallRunner Game is loaded
''', (tester) async {
    final game = BallRunner();
    final widget = GameWidget(game: game);
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();

    expect(find.byType(GameWidget<BallRunner>), findsOneWidget);
  });
  group('BallRunner', () {
    testWithGame('''
      Given the ball runner
      WHEN the Game is loaded
      THEN the BallPlayer is added to the world
      ''', () => BallRunner(), (game) async {
      final component =
          BallPlayer(position: Vector2(128, game.canvasSize.y - 70))
            ..addToParent(game);
      await game.ready();

      expect(component.isMounted, true);
      expect(game.world.children.whereType<BallPlayer>().length, 1);
    });
  });
}
