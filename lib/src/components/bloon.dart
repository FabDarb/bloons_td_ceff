import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bloon extends SpriteComponent
    with HasGameReference<BloonsTdCeffFlame>, CollisionCallbacks {
  Bloon(
      {required this.bloonLevel,
      required this.spriteImage,
      this.speedMultiplier = 1})
      : super(
            size: Vector2(30, 40),
            priority: 2,
            children: [RectangleHitbox(isSolid: true)]);

  double speed = 0;
  double speedMultiplier = 1;
  double health = 0;
  double bloonLevel;
  double lifeTime = 0;
  int targetPos = 0;
  Vector2 velocity = Vector2.zero();
  Image spriteImage;
  late Vector2 targetPosition;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    initAttributs(bloonLevel.toInt());
    anchor = Anchor.center;
    reset(bloonLevel.toInt(), speedMultiplier);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.distanceTo(targetPosition) > 5) {
      position += velocity * dt;
    } else {
      position = targetPosition;
      if (targetPos < bloonsPath.length - 1) {
        goToTarget(target: bloonsPath[++targetPos]);
      } else {
        game.totalHealth -= health;
        destroy();
      }
    }
    lifeTime += dt;
  }

  void goToTarget({Vector2? target}) {
    targetPosition = target ?? targetPosition;
    final offset = targetPosition - position;
    velocity = Vector2(speed, 0);
    final targetAngle = atan2(offset.y, offset.x);
    velocity.rotate(targetAngle);
  }

  void initAttributs(int level) {
    Map<String, Object>? attributs = bloonsLevel[level];
    sprite = Sprite(
      spriteImage,
      srcPosition: attributs!["spritePos"] as Vector2,
      srcSize: attributs["spriteSize"] as Vector2,
    );
    speed = (attributs["speed"] as double) * speedMultiplier;
    health = attributs["health"] as double;
  }

  void reset(int level, double speedMultiplier) {
    velocity = Vector2.zero();
    targetPosition = bloonsPath.first;
    targetPos = 0;
    position = bloonsPath.first;
    lifeTime = 0;
    this.speedMultiplier = speedMultiplier;
    bloonLevel = level.toDouble();
    health = level.toDouble();
    initAttributs(level);
  }

  void takeDamage(double damage) {
    health -= damage;
    ++game.coins;
    game.playArea.playground.add(game.bloonHitEffectPool.aquireObject(
        () => BloonHitEffect(position),
        initFunct: (effect) => effect.init(position)));
    if (health <= 0) {
      destroy();
    } else {
      initAttributs(health.toInt());
      goToTarget();
    }
  }

  void destroy() {
    game.bloonsPool.release(
      this,
    );
    removeFromParent();
  }
}
