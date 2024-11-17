import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BallRunner extends FlameGame {
  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ball.png',
      'ground.png',
    ]);
    camera.viewfinder.anchor = Anchor.topLeft;
  }
}
