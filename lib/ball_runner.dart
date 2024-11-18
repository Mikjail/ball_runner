import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:my_runner_game/actors/ball_player.dart';

class BallRunner extends FlameGame {
  late BallPlayer _ball;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ball.png',
      'ground.png',
    ]);
    camera.viewfinder.anchor = Anchor.topLeft;

    _ball = BallPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );

    world.add(_ball);
  }
}
