import 'package:bloons_td_ceff/bloons_td_ceff.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Playground extends SpriteComponent
    with HasGameReference<BloonsTdCeffFlame>, TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (game.typeOfMonkey != TypeOfMonkey.none &&
        game.hud.monkeyOverlay!.isPossable) {
      game.coins -= game.hud.monkeyOverlay!.price;
      if (game.typeOfMonkey != TypeOfMonkey.basic) {
        add(BasicMonkey(event.localPosition));
        game.typeOfMonkey = TypeOfMonkey.none;
      } else if (game.typeOfMonkey != TypeOfMonkey.souper) {
        add(SouperMonkey(event.localPosition));
        game.typeOfMonkey = TypeOfMonkey.none;
      }
    }
  }
}
