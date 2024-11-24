import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:my_runner_game/actors/ball_player.dart';
import 'package:my_runner_game/managers/segment_manager.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

class BallRunner extends FlameGame {
  late BallPlayer _ball;
  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ball.png',
      'ground.png',
      'block.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame();
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
}
