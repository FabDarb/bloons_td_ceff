import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart' as ev;

import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent
    with HasGameReference<BloonsTdCeffFlame>, ev.PointerMoveCallbacks {
  PlayArea()
      : super(
          paint: Paint()..color = Colors.blue,
        );

  late SpriteComponent playground;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    size = Vector2(game.width, game.height);
    playground = Playground()
      ..anchor = Anchor.center
      ..position = size / 2
      ..sprite = Sprite(
        game.backgroundSpriteImage,
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(750, 600),
      )
      ..priority = 0;
    add(playground);

    int index = 1;
    for (var pos in bloonsPath) {
      playground.add(
        RectangleComponent(
            size: Vector2(20, 20),
            paint: Paint()..color = Colors.red,
            position: pos,
            priority: 200,
            anchor: Anchor.center,
            children: [TextComponent(text: index.toString())]),
      );
      ++index;
    }
    addPathHitBox();
  }

  void addPathHitBox() {
    for (int i = 0; i < bloonsPath.length - 1; ++i) {
      final firstPos = bloonsPath[i];
      final secondPos = bloonsPath[i + 1];
      Anchor newAnchor;
      if (firstPos.y == secondPos.y && firstPos.x > secondPos.x) {
        newAnchor = Anchor.centerRight;
      } else if (firstPos.y == secondPos.y && firstPos.x < secondPos.x) {
        newAnchor = Anchor.centerLeft;
      } else if (firstPos.y < secondPos.y && firstPos.x == secondPos.x) {
        newAnchor = Anchor.topCenter;
      } else {
        newAnchor = Anchor.bottomCenter;
      }
      Vector2 newSize = Vector2(
        (secondPos.x - firstPos.x == 0 ? 40 : secondPos.x - firstPos.x)
            .abs()
            .toDouble(),
        (secondPos.y - firstPos.y == 0 ? 40 : secondPos.y - firstPos.y)
            .abs()
            .toDouble(),
      );
      playground.add(PathRectangle(newSize, firstPos, newAnchor));
    }
  }

  @override
  void onPointerMove(ev.PointerMoveEvent event) {
    super.onPointerMove(event);
    if (game.hud.monkeyOverlay != null) {
      game.hud.monkeyOverlay!.position = event.localPosition;
    }
  }
}
