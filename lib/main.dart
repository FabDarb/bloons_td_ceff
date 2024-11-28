import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const OurApp());
}

class OurApp extends StatefulWidget {
  const OurApp({super.key});

  @override
  State<OurApp> createState() => _OurAppState();
}

class _OurAppState extends State<OurApp> {
  late BloonsTdCeffFlame newGame;

  @override
  void initState() {
    super.initState();
    newGame = BloonsTdCeffFlame();
  }

  void refreshGame() {
    newGame = BloonsTdCeffFlame(startOption: StartOptions.restart);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: GameWidget(
        game: newGame,
        overlayBuilderMap: {
          MainScreen.routeName: (_, game) =>
              MainScreen(game: game as BloonsTdCeffFlame),
          PauseMenuOverlay.routeName: (_, game) =>
              PauseMenuOverlay(game: game as BloonsTdCeffFlame),
          GameOverOverlay.routeName: (_, game) => GameOverOverlay(
                game: game as BloonsTdCeffFlame,
                refreshFunction: refreshGame,
              ),
        },
      ),
    );
  }
}
