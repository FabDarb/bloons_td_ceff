import 'dart:async';
import 'dart:ui';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:bloons_td_ceff/src/utils/wave_handler.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/services.dart';

enum TypeOfMonkey {
  none,
  basic,
  souper,
}

enum StartOptions {
  start,
  restart,
}

class BloonsTdCeffFlame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  BloonsTdCeffFlame({this.startOption = StartOptions.start})
      : super(
          camera: CameraComponent.withFixedResolution(
              width: gameWidth, height: gameHeight),
        );

  final StartOptions startOption;

  double get width => size.x;
  double get height => size.y;

  late Image monkeySpriteImage;
  late Image bloonsSpriteImage;
  late Image backgroundSpriteImage;

  PlayArea playArea = PlayArea();
  ObjectPool<Bloon> bloonsPool = ObjectPool<Bloon>();
  ObjectPool<Projectile> projectilesPool = ObjectPool<Projectile>();
  ObjectPool<BloonHitEffect> bloonHitEffectPool = ObjectPool<BloonHitEffect>();

  WaveHandler waveHandler = WaveHandler();

  double totalHealth = 100;
  double coins = 200;

  TypeOfMonkey typeOfMonkey = TypeOfMonkey.none;
  late final hud = Hud();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    if (startOption == StartOptions.start) {
      overlays.add(MainScreen.routeName);
      pauseEngine();
    }
    monkeySpriteImage = await Flame.images.load('monkey_spritesheet.png');
    bloonsSpriteImage = await Flame.images.load('bloons_spritesheet.png');
    backgroundSpriteImage =
        await Flame.images.load('background_spritesheet.png');

    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.add(hud);
    world.add(playArea);
    world.add(waveHandler);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (totalHealth <= 0) {
      overlays.add(GameOverOverlay.routeName);
    }
    if (!overlays.isActive(MainScreen.routeName)) {
      resumeEngine();
    }
  }

  void startGame() {
    overlays.remove(MainScreen.routeName);
    resumeEngine();
  }

  void togglePauseMenuOverlay() {
    if (overlays.isActive(PauseMenuOverlay.routeName)) {
      overlays.remove(PauseMenuOverlay.routeName);
      resumeEngine();
    } else if (overlays.activeOverlays.isEmpty) {
      overlays.add(PauseMenuOverlay.routeName);
      pauseEngine();
    }
  }

  @override
  mat.KeyEventResult onKeyEvent(
      mat.KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is KeyDownEvent;
    final isEscape = keysPressed.contains(LogicalKeyboardKey.escape);

    if (isEscape && isKeyDown) {
      togglePauseMenuOverlay();
      return mat.KeyEventResult.handled;
    }
    return mat.KeyEventResult.ignored;
  }

  @override
  Color backgroundColor() => mat.Colors.blue;
}
