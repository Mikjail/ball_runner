import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerController {
  final Images images;
  final JoystickComponent _joystick;

  PlayerController(this.images)
      : _joystick = JoystickComponent(
          knob: SpriteComponent(
            sprite: Sprite(
              images.fromCache('knob.png'),
            ),
          ),
          background: SpriteComponent(
            sprite: Sprite(
              images.fromCache('joystick.png'),
            ),
          ),
          margin: const EdgeInsets.only(left: 70, bottom: 200),
        ),
        super();

  JoystickComponent get aJoystick => _joystick;

  double getJoystickDirection() {
    switch (_joystick.direction) {
      case JoystickDirection.up:
      case JoystickDirection.down:
      case JoystickDirection.idle:
        return 0;

      case JoystickDirection.upLeft:
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
        return -1;

      case JoystickDirection.upRight:
      case JoystickDirection.right:
      case JoystickDirection.downRight:
        return 1;
    }
  }
}
