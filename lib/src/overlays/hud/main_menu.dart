import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
    required this.game,
  });

  final BloonsTdCeffFlame game;

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: Text('Test'),
      ),
    );
  }
}
