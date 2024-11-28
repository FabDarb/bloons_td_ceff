import 'dart:async';
import 'dart:math';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class BloonHitEffect extends SpriteComponent
    with HasGameReference<BloonsTdCeffFlame> {
  BloonHitEffect(this.effectPosition);

  final Vector2 effectPosition;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size = Vector2.all(60);
    priority = 3;
    anchor = Anchor.center;
    sprite = Sprite(
      game.bloonsSpriteImage,
      srcPosition: Vector2(201, 0),
      srcSize: Vector2(90, 92),
    );

    init(effectPosition);
  }

  void init(Vector2 effectPosition) {
    angle = Random().nextDouble() * (pi * 2);
    position = effectPosition;
    add(RemoveEffect(
      delay: 0.1,
      onComplete: () => game.bloonHitEffectPool.release(this),
    ));
  }
}
