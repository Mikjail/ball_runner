import 'dart:math';

import 'package:flame/components.dart';
import 'package:my_runner_game/managers/platform_generator.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

typedef Segments = List<List<Block>>;

class SegmentManager {
  final _platformGenerator = PlatformGenerator();
  final int numberOfSegments;

  SegmentManager({this.numberOfSegments = 20});

  Segments segments = [segment0, segment1];

  void generate() {
    generateGround();
    generateObstacles();
  }

  void generateGround() {
    final Segments newSegments = [];
    for (var i = 2; i < numberOfSegments; i++) {
      final blocks = <Block>[];
      for (var i = 0; i < 10; i++) {
        blocks.add(Block(Vector2(i.toDouble(), 0), GroundBlock));
      }
      newSegments.add(blocks);
    }
    segments.addAll(newSegments);
  }

  void generateObstacles() {
    for (var i = 2; i < segments.length; i++) {
      final List<Block> obstacles = [];
      double lastObstacleX =
          -2; // Initialize to a value that ensures the first obstacle can be placed
      for (var block in segments[i]) {
        if (block.blockType == GroundBlock) {
          // Ensure there is a space of 3 blocks between obstacles
          if (block.gridPosition.x >= lastObstacleX + 2) {
            // 0.33 chance to place an obstacle above the ground block
            if (Random().nextInt(3) == 0) {
              final generatedPlatforms = _platformGenerator.generatePlatform(
                  startPosition:
                      Vector2(block.gridPosition.x, block.gridPosition.y + 1),
                  type: PlatformType.vertical,
                  length: Random().nextInt(3) + 1);
              obstacles.addAll(generatedPlatforms);
              lastObstacleX =
                  block.gridPosition.x; // Update the last obstacle position
            }
          }
        }
      }
      segments[i].addAll(obstacles);
    }
  }
}

class Block {
  final Vector2 gridPosition;
  final Type blockType;
  Block(this.gridPosition, this.blockType);
}

final segment0 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(2, 0), GroundBlock),
  Block(Vector2(3, 0), GroundBlock),
  Block(Vector2(4, 0), GroundBlock),
  Block(Vector2(5, 0), GroundBlock),
  Block(Vector2(6, 0), GroundBlock),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(5, 3), PlatformBlock),
  Block(Vector2(6, 3), PlatformBlock),
  Block(Vector2(7, 3), PlatformBlock),
  Block(Vector2(8, 3), PlatformBlock),
];

final segment1 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(4, 0), GroundBlock),
  Block(Vector2(5, 0), GroundBlock),
  Block(Vector2(6, 0), GroundBlock),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(1, 1), PlatformBlock),
  Block(Vector2(1, 2), PlatformBlock),
  Block(Vector2(1, 3), PlatformBlock),
  Block(Vector2(2, 6), PlatformBlock),
  Block(Vector2(3, 6), PlatformBlock),
  Block(Vector2(6, 5), PlatformBlock),
  Block(Vector2(7, 5), PlatformBlock),
  Block(Vector2(8, 1), PlatformBlock),
  Block(Vector2(8, 5), PlatformBlock),
];
