import 'dart:collection';
import 'dart:math';

import 'package:bloons_td_ceff/bloons_td_ceff.dart';
import 'package:flame/components.dart';

class WaveHandler extends Component with HasGameReference<BloonsTdCeffFlame> {
  int round = 0;

  Queue<Wave> waveQueue = Queue();
  Wave? currentWave;

  double spawnTimer = 0;
  double delayTimer = 0;

  void startRound(int round) {
    for (int i = 0; i < round; i++) {
      final wave = Wave(min(i + round, 4), 5 + round);
      waveQueue.add(wave);
    }
  }

  void spawnBloon() {
    if (currentWave!.bloons <= 0) {
      currentWave = null;

      return;
    }
    game.playArea.playground.add(game.bloonsPool.aquireObject(
        () => Bloon(
            bloonLevel: currentWave!.level.toDouble(),
            spriteImage: game.bloonsSpriteImage),
        initFunct: (bloon) => bloon.reset(currentWave!.level, 1 + round / 20)));
    --currentWave!.bloons;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (waveQueue.isNotEmpty && currentWave == null) {
      currentWave = waveQueue.removeFirst();
    } else if (waveQueue.isEmpty &&
        currentWave == null &&
        game.playArea.children.query<Bloon>().toList().isEmpty) {
      if (delayTimer > 2) {
        delayTimer = 0;
        startRound(++round);
      }
      delayTimer += dt;
    }

    if (currentWave != null) {
      if (spawnTimer > max(0.8 - round / 10, 0.15)) {
        spawnTimer = 0;

        spawnBloon();
      }
      spawnTimer += dt;
    }
  }
}
