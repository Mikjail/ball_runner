import 'package:flame/components.dart';
import 'package:my_runner_game/managers/segment_manager.dart' as manager;
import 'package:my_runner_game/objects/platform_block.dart';

class PlatformGenerator {
  List<manager.Block> generatePlatform({
    required Vector2 startPosition,
    required PlatformType type,
    required int length,
  }) {
    List<manager.Block> blocks = [];
    for (int i = 0; i < length; i++) {
      Vector2 position;
      switch (type) {
        case PlatformType.horizontal:
          position = Vector2(startPosition.x + i, startPosition.y);
          break;
        case PlatformType.vertical:
          position = Vector2(startPosition.x, startPosition.y + i);
          break;
        case PlatformType.diagonal:
          position = Vector2(startPosition.x + i, startPosition.y + i);
          break;
      }
      blocks.add(manager.Block(position, PlatformBlock));
    }
    return blocks;
  }
}

enum PlatformType {
  vertical,
  horizontal,
  diagonal,
}
