import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/actors/player_controller.dart';
import 'package:my_runner_game/managers/segment_manager.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

class BallRunner extends FlameGame with HasCollisionDetection {
  late BallPlayer _ball;
  double objectSpeed = 100.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  late PlayerController controller;
  List<PositionComponent> segmentObjects = [];
  final _segmentManager = SegmentManager(numberOfSegments: 8);
  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'background.png',
      'ball_running.png',
      'ground.png',
      'block.png',
      'joystick.png',
      'knob.png',
    ]);

    add(Background());

    await initializeGame();
  }

  @override
  void update(double dt) {
    updateJoystickDirection();
    super.update(dt);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    final segments = _segmentManager.segments;
    for (final block in segments[segmentIndex]) {
      final component = switch (block.blockType) {
        const (GroundBlock) => GroundBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
            numberOfSegments: segments.length,
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

  Future<void> initializeGame() async {
    _setupPlayer();

    _setupController();

    _setupSegments();

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
    _segmentManager.generate();

    final segmentsToLoad =
        (size.x / 500).ceil().clamp(0, _segmentManager.segments.length);

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
    camera.setBounds(Rectangle.fromLTRB(0, 0, size.x, size.y - 100),
        considerViewport: true);

    camera.follow(
      _ball,
    );
  }

  void updateJoystickDirection() {
    _ball.horizontalMovement = controller.getJoystickDirection();
  }

  @override
  void onRemove() {
    // Optional based on your game needs.
    removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
    // Any other code that you want to run when the game is removed.
  }
}

class Background extends ParallaxComponent<BallRunner> {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData('background.png'),
      ],
      baseVelocity: Vector2.zero(),
      velocityMultiplierDelta: Vector2(1.0, 0.0),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update the parallax velocity based on the ball's movement
    if (game._ball.horizontalMovement > 0) {
      parallax?.baseVelocity = Vector2(-game.objectSpeed, 0);
    } else {
      parallax?.baseVelocity = Vector2.zero();
    }
  }
}
