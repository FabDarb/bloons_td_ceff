import 'dart:io';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';
  const MainScreen({required this.game, super.key});

  final BloonsTdCeffFlame game;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Bloon TD Ceff',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              ImageButton(
                onTap: () {
                  widget.game.startGame();
                },
                image: Image.asset('assets/images/button_images/PlayBtn.png'),
                clickImage:
                    Image.asset('assets/images/button_images/PlayClick.png'),
                width: 300,
                height: 100,
              ),
              const SizedBox(height: 20),
              ImageButton(
                onTap: () {},
                image: Image.asset('assets/images/button_images/OptBtn.png'),
                clickImage:
                    Image.asset('assets/images/button_images/OptClick.png'),
                width: 300,
                height: 100,
              ),
              const SizedBox(height: 20),
              ImageButton(
                image: Image.asset('assets/images/button_images/ExitBtn.png'),
                clickImage:
                    Image.asset('assets/images/button_images/ExitClick.png'),
                onTap: () {
                  exit(0);
                },
                width: 300,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
