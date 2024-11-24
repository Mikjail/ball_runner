import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/ball_runner.dart';
import 'package:my_runner_game/objects/platform_block.dart';

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
      BallPlayer component = await makeSut(game);

      expect(component.isMounted, true);
      expect(game.world.children.whereType<BallPlayer>().length, 1);
    });

    testWithGame('''
    Given the Ball Runner
    WHEN the game is loaded
    THEN the game should have a velocity speed set as default to 0.0
    ''', () => BallRunner(), (game) async {
      BallPlayer component = await makeSut(game);

      expect(component.isMounted, true);
      expect(game.objectSpeed, 0.0);
    });

    testWithGame('''
    Given the Ball Runner
    WHEN the game is loaded
    THEN the game should initialize PlatformBlock component
    AND add 3 in the vector  1,1 1,2 1,3
    ''', () => BallRunner(), (game) async {
      BallPlayer component = await makeSut(game);

      expect(component.isMounted, true);
      final blocks = game.world.children.whereType<PlatformBlock>().toList();

      expect(blocks[0].gridPosition, Vector2(5, 3));
      expect(blocks[1].gridPosition, Vector2(6, 3));
      expect(blocks[2].gridPosition, Vector2(7, 3));
      expect(blocks[3].gridPosition, Vector2(8, 3));
    });
  });
  testWithGame('''
GIVEN the Ball Player initalized
AND the initial animation is set
THEN ball player should be set as running
''', () => BallRunner(), (game) async {
    BallPlayer component = await makeSut(game);

    expect(component.isMounted, true);

    expect(component.current, BallPlayerState.running);
  });
}

Future<BallPlayer> makeSut(BallRunner game) async {
  final component = BallPlayer(position: Vector2(128, game.canvasSize.y - 70))
    ..addToParent(game);
  await game.ready();
  return component;
}
