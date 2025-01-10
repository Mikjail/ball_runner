import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/player_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
      'GIVEN the Controls WHEN it is initialized THEN it should initialized the joystick',
      () async {
    //mock images
    final images = Images();
    await images.loadAll([
      'joystick.png',
      'knob.png',
    ]);
    final sut = PlayerController(images);

    expect(sut.aJoystick, isA<JoystickComponent>());
  });
}
