import 'dart:async';
import 'dart:math';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Projectile extends SpriteComponent
    with HasGameReference<BloonsTdCeffFlame>, CollisionCallbacks {
  Projectile(
    this.speed,
    this.damage,
    this.directionAngle,
    this.newPosition,
  ) : super(
            size: Vector2(10, 40),
            priority: 1,
            anchor: Anchor.center,
            children: [
              RectangleHitbox(isSolid: true),
            ]);
  final double speed;
  double directionAngle;
  final double damage;
  final Vector2 newPosition;
  Bloon? damagingBloon;

  Vector2 velocity = Vector2.zero();

  double lifeTime = 4;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    sprite = Sprite(
      game.monkeySpriteImage,
      srcPosition: Vector2(780, 2),
      srcSize: Vector2(18, 97),
    );
    reset(directionAngle, newPosition);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (lifeTime <= 0) {
      destroy();
    }
    lifeTime -= dt;
  }

  void reset(double newAngle, Vector2 newPosition) {
    angle = newAngle + pi / 2;
    directionAngle = newAngle;
    position = newPosition;
    lifeTime = 4;
    velocity = Vector2(speed, 0);
    velocity.rotate(directionAngle);
  }

  void destroy() {
    removeFromParent();
    game.projectilesPool.release(this);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bloon) {
      damagingBloon = damagingBloon ?? other;

      if (damagingBloon != null) {
        velocity = Vector2.zero();
        other.takeDamage(damage);
        game.projectilesPool.release(
          this,
          destroyeFunct: (object) => object.destroy(),
        );
      }
    }
  }
}
