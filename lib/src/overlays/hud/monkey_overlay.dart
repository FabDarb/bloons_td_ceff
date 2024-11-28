import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class MonkeyOverlay extends SpriteComponent
    with HasGameReference<BloonsTdCeffFlame>, CollisionCallbacks {
  MonkeyOverlay(
    this.typeOfMyMonkey,
    this.price,
    Vector2 newSize,
  ) : super(priority: 5, size: newSize, anchor: Anchor.center, children: [
          CircleHitbox(
            isSolid: true,
            collisionType: CollisionType.passive,
            radius: newSize.x / 4,
            position: Vector2.all(newSize.x / 2),
            anchor: Anchor.center,
          )
        ]);
  final TypeOfMonkey typeOfMyMonkey;
  final List<PositionComponent> listOfCollision = <PositionComponent>[];
  final double price;

  bool _isPossable = true;
  bool _changeBool = true;
  bool get changeBool => _changeBool;
  set changeBool(bool newChange) {
    _changeBool = newChange;
    if (_changeBool) {
      if (listOfCollision.isEmpty) {
        isPossable = false;
      } else {
        isPossable = true;
      }
    }
  }

  bool get isPossable => _isPossable;
  set isPossable(bool possable) {
    _isPossable = possable;
    addEffect();
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
    if (typeOfMyMonkey != TypeOfMonkey.none) {
      sprite = Sprite(
        game.monkeySpriteImage,
        srcPosition: monkeys[typeOfMyMonkey]!["spritePos"] as Vector2,
        srcSize: monkeys[typeOfMyMonkey]!["spriteSize"] as Vector2,
      );
      add(
        CircleComponent(
            radius: monkeys[typeOfMyMonkey]!["attackRange"] as double,
            paint: Paint()..color = const Color.fromARGB(50, 0, 0, 0),
            anchor: Anchor.center,
            position: Vector2.all(size.x / 2)),
      );
    }
  }

  void addEffect() {
    if (!_isPossable) {
      add(
        ColorEffect(
          Colors.red,
          opacityTo: 0.5,
          EffectController(duration: 0),
        ),
      );
    } else {
      add(
        ColorEffect(
          Colors.green,
          opacityTo: 0.5,
          EffectController(duration: 0),
        ),
      );
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Monkey || other is PathRectangle) {
      if (listOfCollision.isEmpty) {
        changeBool = true;
      } else {
        changeBool = false;
      }
      listOfCollision.add(other);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (listOfCollision.contains(other)) {
      if (listOfCollision.isNotEmpty && listOfCollision.length == 1) {
        changeBool = true;
      } else {
        changeBool = false;
      }
      listOfCollision.remove(other);
    }
  }
}
