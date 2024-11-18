import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/ball_player.dart';

void main() {
  test('''
GIVEN the ball Player
WHEN initialized 
THEN it should set the position size and anchor according to the image sprite

''', () {
    final sut = BallPlayer(position: Vector2.all(0));

    expect(sut.position, Vector2.all(0));
    expect(sut.size, Vector2.all(50));
    expect(sut.anchor, Anchor.center);
  });
}
