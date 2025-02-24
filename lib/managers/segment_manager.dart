import 'dart:math';

import 'package:flame/components.dart';
import 'package:my_runner_game/managers/platform_generator.dart';
import 'package:my_runner_game/objects/ground_block.dart';
import 'package:my_runner_game/objects/platform_block.dart';

typedef Segments = List<List<Block>>;

class SegmentManager {
  final _platformGenerator = PlatformGenerator();
  final int numberOfSegments;

  SegmentManager({this.numberOfSegments = 2});

  Segments segments = [
    segment0,
    segment1,
  ];

  void generate() {
    generateGround();
    // generateObstacles();
  }

  void generateGround() {
    var maxEmptyGrounds = 1;
    for (var i = 0; i < numberOfSegments; i++) {
      final segment = <Block>[];
      if (i % 2 == 0 && maxEmptyGrounds < 3) {
        maxEmptyGrounds++;
      }
      var emptyGroundBySegment = 0;
      // go through each block in the segment
      for (var col = 0; col < 10; col++) {
        // 0.33 chance to have an empty ground
        if (emptyGroundBySegment < maxEmptyGrounds &&
            Random().nextInt(2) == 0) {
          emptyGroundBySegment++;
          continue;
        }
        segment.add(Block(Vector2(col.toDouble(), 0), GroundBlock));
      }
      segments.add(segment);
    }
  }

  void generateBackGround() {}

  void generateObstacles() {
    final obstacleSpace = 3;
    for (var i = 2; i < segments.length; i++) {
      final segment = segments[i];
      var obstacleCountBySegment = 0;
      var obstacles = <Block>[];
      for (var j = 0; j < segment.length; j++) {
        if (segment[j].blockType == GroundBlock &&
            obstacleCountBySegment < 2 &&
            Random().nextInt(2) == 0) {
          obstacleCountBySegment++;
          obstacles.addAll(_platformGenerator.generatePlatform(
              startPosition: Vector2(j.toDouble(), 1),
              type: PlatformType.vertical,
              length: 3));
          j += obstacleSpace;
        }
      }
      segment.addAll(obstacles);
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
