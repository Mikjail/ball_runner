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

  // When player moves it is movung either left or right, this is used to set
  double horizontalMovement = 0;
  double moveSpeed = 200;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    animations = {
      PlayerState.idle: await game.loadSpriteAnimation(
        'ball_iddle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2.all(50),
          stepTime: 0.2,
        ),
      ),
      PlayerState.running: await game.loadSpriteAnimation(
        'ball_running.png',
        SpriteAnimationData.sequenced(
          amount: 24,
          textureSize: Vector2.all(50),
          stepTime: 0.034,
        ),
      ),
    };

    current = PlayerState.idle;
    _lastPosition.setFrom(position);
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  void _updatePlayerMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    }
    if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    if (velocity.x > 0 || velocity.x < 0) {
      playerState = PlayerState.running;
    }
    current = playerState;
  }
}

enum PlayerState {
  running,
  idle,
}

enum PlayerDirection {
  left,
  right,
  idle,
  none,
}
