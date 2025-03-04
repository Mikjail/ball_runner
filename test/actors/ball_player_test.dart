import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/ball_player.dart';

void main() {
  test('''
GIVEN the Ball Player
WHEN initialized 
THEN it should set the position size and anchor according to the image sprite
''', () {
    final sut = BallPlayer(position: Vector2.all(0));

    expect(sut.position, Vector2.all(0));
    expect(sut.size, Vector2.all(50));
    expect(sut.anchor, Anchor.center);
  });

  test('''
    GIVEN the Ball Player initalized
    WHEN the initial position is set
    THEN the isFalling property should be false
    ''', () {
    final sut = BallPlayer(position: Vector2.all(0));

    expect(sut.isFalling, false);
  });

  test('''
    GIVEN the Ball Player 
    WHEN initalized
    THEN the horizontal movement should be zero
    ''', () {
    final sut = BallPlayer(position: Vector2.all(0));

    expect(sut.horizontalMovement, 0);
  });
}
