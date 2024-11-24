import 'package:flame/components.dart';
import 'package:my_runner_game/ball_runner.dart';

class BallPlayer extends SpriteAnimationGroupComponent
    with HasGameReference<BallRunner> {
  BallPlayer({
    required super.position,
  }) : super(size: Vector2.all(50), anchor: Anchor.center);
// Used to store the last position of the player, so that we later can
  // determine which direction that the player is moving.
  final Vector2 _lastPosition = Vector2.zero();

  // When the player has velocity pointing downwards it is counted as falling,
  // this is used to set the correct animation for the player.
  bool get isFalling => _lastPosition.y < position.y;

  @override
  Future<void> onLoad() async {
    animations = {
      BallPlayerState.running: await game.loadSpriteAnimation(
        'ball.png',
        SpriteAnimationData.sequenced(
          amount: 24,
          textureSize: Vector2.all(50),
          stepTime: 0.034,
        ),
      )
    };

    current = BallPlayerState.running;
    _lastPosition.setFrom(position);
  }
}

enum BallPlayerState {
  running,
}
