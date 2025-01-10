import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:my_runner_game/ball_runner.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

class BallPlayer extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameReference<BallRunner> {
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

  // This is for the collision
  final Vector2 fromAbove = Vector2(0, -1);
  final Vector2 fromBelow = Vector2(0, 1);
  bool isOnGround = false;

  // Gravity and ability to jump
  final double _gravity = 9.81;
  final double _jumpForce = 380; // You may need to adjust this value
  final double _terminalVelocity = 300;

  bool hasJumped = false;

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

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _applyGravity(dt);
    _scrollWithPlayer(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GroundBlock || other is PlatformBlock) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // If collision normal is almost upwards,
        // ember must be on ground.
        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        // If collision normal is almost downwards,
        // ball must be hitting the bottom of the platform.
        if (fromBelow.dot(collisionNormal) > 0.9) {
          if (other is PlatformBlock) {
            // Reverse the vertical velocity to make the ball bounce down
            velocity.y = -velocity.y;
          }
        }

        // Resolve collision by moving ember along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);

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

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    hasJumped = false;
    isOnGround = false;
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    position.y += velocity.y * dt;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);

    _handleBlockCollision();
  }

  void _scrollWithPlayer(double dt) {
    game.objectSpeed = 0;
    // Prevent ember from going backwards at screen edge.
    if (position.x - 36 <= 0 && horizontalMovement < 0) {
      velocity.x = 1;
    }
    // Prevent ball from going beyond half screen.
    if (position.x + 64 >= game.size.x / 2 && horizontalMovement > 0) {
      velocity.x = 1;
      game.objectSpeed = -moveSpeed;
    }
  }

  void _handleBlockCollision() {}
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
