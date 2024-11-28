import 'package:bloons_td_ceff/bloons_td_ceff.dart';

import 'package:flame/components.dart';

class SouperMonkey extends Monkey {
  SouperMonkey(this.monkeyPosition, {super.newSize});
  @override
  final Vector2 monkeyPosition;

  @override
  TypeOfMonkey get typeOfThisMonkey => TypeOfMonkey.souper;

  @override
  Vector2 get monkeySize => Vector2(80, 80);
}
