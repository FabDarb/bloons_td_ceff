import 'dart:async';
import 'dart:math';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MonkeyStates {
  wating,
  attacking,
}

abstract class Monkey extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameReference<BloonsTdCeffFlame> {
  Monkey({
    this.attackRange = 100,
    this.attackSpeed = 1,
    this.newSize,
  }) : super(
          priority: 3,
          anchor: Anchor.center,
          current: MonkeyStates.wating,
        );

  late double attackRange;
  late double attackSpeed;
  CircleHitbox hitBox = CircleHitbox(isSolid: true);
  final Vector2? newSize;

  abstract final TypeOfMonkey typeOfThisMonkey;
  abstract final Vector2 monkeyPosition;
  abstract final Vector2 monkeySize;

  Bloon? targetBloon;
  bool bloonExitedRange = false;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(hitBox);
    size = newSize ?? monkeySize;
    final stats = monkeys[typeOfThisMonkey];
    if (stats != null) {
      attackRange = stats['attackRange'] as double;
      attackSpeed = stats['attackSpeed'] as double;

      animations = {
        MonkeyStates.wating: getAnimation(
          srcSize: stats['spriteSize'] as Vector2,
          frames: [
            stats['spritePos'] as Vector2,
          ],
        ),
        MonkeyStates.attacking: getAnimation(
          srcSize: stats['spriteSize'] as Vector2,
          frames: stats['spriteVectorFrames'] as List<Vector2>,
          stepTime: 0.1 / attackSpeed,
        ),
      };
    }
    add(
      CircleHitbox(
        radius: attackRange,
        position: size / 2,
        anchor: Anchor.center,
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    animationTickers?[MonkeyStates.attacking]?.onFrame = (frame) {
      if (frame == 4) shoot();
    };
    position = monkeyPosition;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (targetBloon != null) {
      final offset = targetBloon!.position - position;
      final targetAngle = atan2(offset.y, offset.x);

      if (angle - targetAngle > pi / 8 || true) {
        rotate(targetAngle, dt);
      }

      if (bloonExitedRange) {
        bloonExitedRange = false;
        targetBloon = null;
        current = MonkeyStates.wating;
        shoot();
      }
    }
  }

  void rotate(double targetAngle, double dt) {
    if (angle != targetAngle) {
      angle += dt * shortestAngleBetween(angle, targetAngle) * pi * 2;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bloon && (targetBloon == null)) {
      targetBloon = other;
    }
    if (other is Bloon) {
      current = MonkeyStates.attacking;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other == targetBloon) {
      bloonExitedRange = true;
    }
  }

  void shoot() {
    if (targetBloon != null) {
      const projectileSpeed = 500.0;
      final offset = targetBloon!.position - position;
      final a = dot2(targetBloon!.velocity, targetBloon!.velocity) -
          (projectileSpeed * projectileSpeed);
      final b = 2 * dot2(targetBloon!.velocity, offset);
      final c = dot2(offset, offset);

      final p = -b / (2 * a);
      final q = sqrt((b * b) - 4 * a * c) / (2 * a);

      final t1 = p - q;
      final t2 = p + q;
      late double t;

      if (t1 > t2 && t2 > 0) {
        t = t2;
      } else {
        t = t1;
      }

      final aimSpot = targetBloon!.position + targetBloon!.velocity * t;
      final futureOffset = aimSpot - position;
      final shootAngle = atan2(futureOffset.y, futureOffset.x);

      game.playArea.playground.add(game.projectilesPool.aquireObject(
          () => Projectile(projectileSpeed, 1, shootAngle, position),
          initFunct: (projectile) {
        projectile.reset(shootAngle, position);
      }));

      current = MonkeyStates.wating;
      // if (current == MonkeyStates.wating) {
      //   targetBloon = null;
      // }
    }
  }

  SpriteAnimation getAnimation(
      {required List<Vector2> frames,
      double stepTime = double.infinity,
      required Vector2 srcSize}) {
    return SpriteAnimation.spriteList(
      // loop: false,
      frames
          .map(
            (vector) => Sprite(game.monkeySpriteImage,
                srcSize: srcSize, srcPosition: vector),
          )
          .toList(),
      stepTime: stepTime,
    );
  }
}
