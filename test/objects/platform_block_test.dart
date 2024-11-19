import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/objects/platform_block.dart';

void main() {
  test('''
GIVEN the Platform Block
WHEN initialized 
THEN it should set the grid position and x offset
''', () {
    final sut = PlatformBlock(gridPosition: Vector2.all(0), xOffset: 0.0);

    expect(sut.gridPosition, Vector2.all(0));
    expect(sut.xOffset, 0.0);
  });
}
