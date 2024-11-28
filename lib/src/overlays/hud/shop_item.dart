import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ShopItem extends RectangleComponent
    with HasGameReference<BloonsTdCeffFlame>, TapCallbacks {
  ShopItem(
    Vector2 newPosition,
    this.monkey,
    this.typeOfMyMonkey,
  ) : super(
          size: Vector2(80, 80),
          position: newPosition,
          paint: Paint()..color = Colors.brown,
        );

  final Monkey monkey;
  final TypeOfMonkey typeOfMyMonkey;
  late double price;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    price = monkeys[typeOfMyMonkey]!["price"] as double;
    add(
      RectangleComponent(
        paint: Paint()..color = Colors.amber,
        size: Vector2(70, 70),
        position: Vector2(5, 5),
        children: [monkey],
      ),
    );
    add(TextComponent(text: price.toString(), position: Vector2(10, 45)));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (game.typeOfMonkey != typeOfMyMonkey && game.coins >= price) {
      game.hud.monkeyOverlay =
          MonkeyOverlay(typeOfMyMonkey, price, monkey.monkeySize);
      game.hud.monkeyOverlay!.position = absolutePosition + Vector2.all(20);
      paint = Paint()..color = Colors.red;
      game.typeOfMonkey = typeOfMyMonkey;
      game.hud.add(game.hud.monkeyOverlay!);
    } else {
      paint = Paint()..color = Colors.brown;
      game.typeOfMonkey = TypeOfMonkey.none;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.typeOfMonkey == TypeOfMonkey.none) {
      paint = Paint()..color = Colors.brown;
      if (game.hud.monkeyOverlay != null) {
        game.hud.monkeyOverlay!.removeFromParent();
      }
    }
  }
}
