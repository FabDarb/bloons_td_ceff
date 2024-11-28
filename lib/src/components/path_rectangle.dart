import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PathRectangle extends RectangleComponent
    with HasGameReference<BloonsTdCeffFlame>, CollisionCallbacks {
  PathRectangle(
    this.newSize,
    this.newPos,
    Anchor newAchor,
  ) : super(
          paint: Paint()..color = Colors.transparent,
          anchor: newAchor,
          children: [
            RectangleHitbox(
              isSolid: true,
            )
          ],
        );
  final Vector2 newSize;
  final Vector2 newPos;
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    priority = 0;
    size = newSize;
    position = newPos;
  }
}
