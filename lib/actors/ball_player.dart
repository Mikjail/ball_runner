import 'package:flame/components.dart';
import 'package:my_runner_game/ball_runner.dart';

class BallPlayer extends SpriteAnimationComponent
    with HasGameReference<BallRunner> {
  BallPlayer({
    required super.position,
  }) : super(size: Vector2.all(50), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ball.png'),
      SpriteAnimationData.sequenced(
        amount: 24,
        textureSize: Vector2.all(50),
        stepTime: 0.034,
      ),
    );
  }
}
