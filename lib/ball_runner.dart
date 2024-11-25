import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/managers/segment_manager.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

class BallRunner extends FlameGame with TapDetector {
  late BallPlayer _ball;
  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  late JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ball_running.png',
      'ground.png',
      'block.png',
      'joystick.png',
      'knob.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame();
  }

  @override
  void update(double dt) {
    updateJoystickDirection();
    super.update(dt);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      final component = switch (block.blockType) {
        const (GroundBlock) => GroundBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ),
        const (PlatformBlock) => PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ),
        _ => null,
      };
      if (component == null) {
        continue;
      }
      world.add(component);
    }
  }

  void initializeGame() {
    // add the joystick to the game
    addJoystick();

    final segmentsToLoad = (size.x / 500).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i < segmentsToLoad; i++) {
      loadGameSegments(i, (500 * i).toDouble());
    }

    _ball = BallPlayer(
      position: Vector2(100, canvasSize.y - 70),
    );

    world.add(_ball);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 70, bottom: 200),
    );
    add(joystick);
  }

  void updateJoystickDirection() {
    switch (joystick.direction) {
      case JoystickDirection.up:
      case JoystickDirection.down:
      case JoystickDirection.idle:
        _ball.horizontalMovement = 0;

      case JoystickDirection.upLeft:
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
        _ball.horizontalMovement = -1;

      case JoystickDirection.upRight:
      case JoystickDirection.right:
      case JoystickDirection.downRight:
        _ball.horizontalMovement = 1;
    }
  }
}
