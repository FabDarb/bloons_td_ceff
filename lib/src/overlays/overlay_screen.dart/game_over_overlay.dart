import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  static const routeName = 'GameOverOverlay';
  const GameOverOverlay({
    super.key,
    required this.game,
    required this.refreshFunction,
  });
  final BloonsTdCeffFlame game;
  final Function refreshFunction;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        color: Colors.red, fontSize: 34, fontWeight: FontWeight.bold);
    game.pauseEngine();
    return Material(
      color: const Color.fromARGB(200, 0, 0, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox.shrink(),
            Text(
              'Game Over',
              style: style,
            ),
            TextButton(
              onPressed: () {
                refreshFunction();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(230, 0, 0, 0))),
              child: Text(
                'Again',
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
