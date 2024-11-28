import 'package:bloons_td_ceff/bloons_td_ceff.dart';

import 'package:flame/components.dart';

class BasicMonkey extends Monkey {
  BasicMonkey(this.monkeyPosition, {super.newSize});
  @override
  final Vector2 monkeyPosition;

  @override
  TypeOfMonkey get typeOfThisMonkey => TypeOfMonkey.basic;

  @override
  Vector2 get monkeySize => Vector2(60, 60);
}
