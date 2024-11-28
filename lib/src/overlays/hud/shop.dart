import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Shop extends RectangleComponent with HasGameReference<BloonsTdCeffFlame> {
  Shop()
      : super(
          paint: Paint()..color = Colors.amberAccent,
          size: Vector2(250, gameHeight - 100),
        );
  Map<TypeOfMonkey, Monkey> monkeys = {
    TypeOfMonkey.basic: BasicMonkey(
      Vector2(30, 20),
      newSize: Vector2(40, 40),
    ),
    TypeOfMonkey.souper: SouperMonkey(
      Vector2(30, 20),
      newSize: Vector2(40, 40),
    )
  };
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = Vector2(game.width - 250, 50);
    double index = 0;
    monkeys.forEach((typeOf, monkey) {
      add(ShopItem(Vector2(index, 0), monkey, typeOf));
      index += 80;
    });
  }
}
