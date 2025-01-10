import 'package:flame/cache.dart';
import 'package:flame/input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/actors/player_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('''
GIVEN the Controls 
WHEN it is initialized 
THEN the Buttons and Joystick are intialized
''', () async {
    //mock images
    final images = Images();
    await images.loadAll([
      'joystick.png',
      'knob.png',
    ]);
    final sut = PlayerController(images: images, onJumpPressed: () {});

    expect(sut.aJoystick, isA<JoystickComponent>());
    expect(sut.aJumpButton, isA<SpriteButtonComponent>());
  });
}
