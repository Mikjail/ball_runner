import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/actors/player_controller.dart';
import 'package:my_runner_game/managers/segment_manager.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

class BallRunner extends FlameGame with HasCollisionDetection {
  late BallPlayer _ball;
  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  late PlayerController controller;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ball_running.png',
      'ground.png',
      'block.png',
      'joystick.png',
      'knob.png',
    ]);

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
    _setupController();

    _setupSegments();

    _setupPlayer();

    _setupCamera();
  }

  void _setupController() {
    // add the joystick and jump button  to the game
    controller = PlayerController(
        images: images,
        onJumpPressed: () {
          _ball.hasJumped = true;
        });

    add(controller.aJoystick);
    add(controller.aJumpButton);
  }

  void _setupSegments() {
    final segmentsToLoad = (size.x / 500).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i < segmentsToLoad; i++) {
      loadGameSegments(i, (500 * i).toDouble());
    }
  }

  void _setupPlayer() {
    _ball = BallPlayer(
      position: Vector2(100, canvasSize.y - 80),
    );

    //adding the ball
    world.add(_ball);
  }

  void _setupCamera() {
    camera.setBounds(Rectangle.fromLTRB(0, 0, size.x, size.y - 500),
        considerViewport: true);
    camera.follow(
      _ball,
    );
  }

  void updateJoystickDirection() {
    _ball.horizontalMovement = controller.getJoystickDirection();
  }
}
