import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/managers/platform_generator.dart';

void main() {
  test('''
GIVEN an PlatformGenerator
WHEN vertical
THEN they should return a platform in vertical position
''', () {
    final sut = PlatformGenerator();
    final result = sut.generatePlatform(
      startPosition: Vector2(0, 0),
      type: PlatformType.vertical,
      length: 3,
    );

    expect(result.length, 3);
    expect(result[0].gridPosition, Vector2(0, 0));
    expect(result[1].gridPosition, Vector2(0, 1));
    expect(result[2].gridPosition, Vector2(0, 2));
  });

  test('''
GIVEN an PlatformGenerator
WHEN horizontal
THEN they should return a platform in horizontal position
''', () {
    final sut = PlatformGenerator();
    final result = sut.generatePlatform(
      startPosition: Vector2(0, 3),
      type: PlatformType.horizontal,
      length: 3,
    );

    expect(result.length, 3);
    expect(result[0].gridPosition, Vector2(0, 3));
    expect(result[1].gridPosition, Vector2(1, 3));
    expect(result[2].gridPosition, Vector2(2, 3));
  });

  test('''
GIVEN an PlatformGenerator
WHEN diagonal
THEN they should return a platform in diagonal position
''', () {
    final sut = PlatformGenerator();
    final result = sut.generatePlatform(
      startPosition: Vector2(0, 3),
      type: PlatformType.diagonal,
      length: 3,
    );

    expect(result.length, 3);
    expect(result[0].gridPosition, Vector2(0, 3));
    expect(result[1].gridPosition, Vector2(1, 4));
    expect(result[2].gridPosition, Vector2(2, 5));
  });
}
