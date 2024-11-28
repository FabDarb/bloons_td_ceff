import 'dart:math';

double shortestAngleBetween(double angle1, double angle2) {
  const twoPi = pi * 2;

  double angle = (angle2 - angle1) % twoPi;

  if (angle >= pi) {
    angle = angle - twoPi;
  }
  if (angle <= -pi) {
    angle = angle + twoPi;
  }
  return angle;
}
