import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';

double gameWidth = 1300;
double gameHeight = 700;

final bloonsPath = [
  Vector2(30, 275), //1
  Vector2(170, 275), //2
  Vector2(170, 145), //3
  Vector2(285, 145), //4
  Vector2(285, 395), //5
  Vector2(130, 395), //6
  Vector2(130, 475), //7
  Vector2(500, 475), //8
  Vector2(500, 345), //9
  Vector2(375, 345), //10
  Vector2(375, 235), //11
  Vector2(500, 235), //12
  Vector2(500, 100), //13
  Vector2(340, 100), //14
  Vector2(340, 50), //15
];

final bloonsLevel = {
  1: {
    "speed": 60.0,
    "health": 1.0,
    "spritePos": Vector2(0, 0),
    "spriteSize": Vector2(43, 60),
  },
  2: {
    "speed": 100.0,
    "health": 2.0,
    "spritePos": Vector2(33, 63),
    "spriteSize": Vector2(49, 68),
  },
  3: {
    "speed": 140.0,
    "health": 3.0,
    "spritePos": Vector2(83, 0),
    "spriteSize": Vector2(55, 75),
  },
  4: {
    "speed": 180.0,
    "health": 4.0,
    "spritePos": Vector2(138, 0),
    "spriteSize": Vector2(60, 85),
  },
};

final monkeys = {
  TypeOfMonkey.basic: {
    "attackRange": 100.0,
    "attackSpeed": 1.0,
    "price": 100.0,
    "spritePos": Vector2(125, 2),
    "spriteSize": Vector2(78, 89),
    "spriteVectorFrames": [
      Vector2(125, 2),
      Vector2(224, 2),
      Vector2(323, 2),
      Vector2(422, 2),
      Vector2(521, 2),
    ],
  },
  TypeOfMonkey.souper: {
    "attackRange": 150.0,
    "attackSpeed": 4.0,
    "price": 200.0,
    "spritePos": Vector2(125, 186.7),
    "spriteSize": Vector2(98, 105.7),
    "spriteVectorFrames": [
      Vector2(125, 186.7),
      Vector2(241, 186.7),
      Vector2(357, 186.7),
      Vector2(473, 186.7),
      Vector2(589, 186.7),
    ],
  },
};
