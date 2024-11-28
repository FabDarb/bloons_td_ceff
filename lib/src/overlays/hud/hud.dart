import 'dart:async';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';

class Hud extends PositionComponent with HasGameReference<BloonsTdCeffFlame> {
  late TextComponent _coinTextComponent;
  late TextComponent _healthBarComponent;
  late TextComponent _roundTextComponent;
  MonkeyOverlay? monkeyOverlay;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    _coinTextComponent = TextComponent(
      text: '${game.coins}',
    );

    add(_coinTextComponent);

    final coinSprite = await game.loadSprite('coins.png');
    final heartSprite = await game.loadSprite('heart.png');
    add(
      SpriteComponent(
        sprite: coinSprite,
        position: Vector2(80, 15),
        size: Vector2.all(24),
        anchor: Anchor.center,
      ),
    );
    _healthBarComponent = TextComponent(
        text: '${game.totalHealth}', position: Vector2(game.width - 100, 0));
    add(_healthBarComponent);

    add(
      SpriteComponent(
        sprite: heartSprite,
        position: Vector2(game.width - 25, 12),
        size: Vector2.all(24),
        anchor: Anchor.center,
      ),
    );
    add(Shop());
    _roundTextComponent = TextComponent(
      text: 'Wave : ${game.waveHandler.round}',
      position: Vector2(game.width / 2 - 100, 0),
    );
    add(_roundTextComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _coinTextComponent.text = '${game.coins}';
    _healthBarComponent.text = '${game.totalHealth}';
    _roundTextComponent.text = 'Wave : ${game.waveHandler.round}';
  }
}
