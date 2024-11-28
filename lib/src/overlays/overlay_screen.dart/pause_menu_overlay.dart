import 'dart:io';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flutter/material.dart';

class PauseMenuOverlay extends StatefulWidget {
  static const routeName = 'PauseMenu';
  const PauseMenuOverlay({required this.game, super.key});
  final BloonsTdCeffFlame game;
  @override
  State<PauseMenuOverlay> createState() => _PauseMenuOverlayState();
}

class _PauseMenuOverlayState extends State<PauseMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(50, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 20),
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                ImageButton(
                  image:
                      Image.asset('assets/images/button_images/ClickIcon.png'),
                  clickImage: Image.asset(
                      'assets/images/button_images/PlayIconClick.png'),
                  onTap: () {
                    widget.game.togglePauseMenuOverlay();
                  },
                  width: 100,
                  height: 100,
                ),
                const Expanded(child: SizedBox()),
                ImageButton(
                  image:
                      Image.asset('assets/images/button_images/ExitIcon.png'),
                  clickImage: Image.asset(
                      'assets/images/button_images/ExitIconClick.png'),
                  onTap: () {
                    exit(0);
                  },
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
