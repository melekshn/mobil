import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AppleViewModel extends ChangeNotifier {
  List<FallingApple> apples = [];
  int score = 0;
  double basketX = 0.4;
  int collectedCount = 0;
  bool gameOver = false;

  late Timer appleTimer;
  late Timer updateTimer;
  final Random random = Random();

  void startGame(VoidCallback onGameOver) {
    appleTimer = Timer.periodic(const Duration(milliseconds: 1500), (_) => addApple());
    updateTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      updateApples(onGameOver);
    });
  }

  void disposeGame() {
    appleTimer.cancel();
    updateTimer.cancel();
  }

  void addApple() {
    final value = random.nextBool() ? 2 : 5;
    apples.add(
      FallingApple(
        value: value,
        x: random.nextDouble(),
        y: 0.0,
        speed: 0.008 + random.nextDouble() * 0.005,
      ),
    );
    notifyListeners();
  }

  void updateApples(VoidCallback onGameOver) {
    for (var apple in apples) {
      apple.y += apple.speed;

      if (apple.y > 0.8 && (apple.x - basketX).abs() < 0.08) {
        if (apple.value == 2) {
          score += 2;
        } else {
          score -= 5;
        }
        collectedCount++;
        debugPrint("Toplanan elma: $collectedCount");
        apple.collected = true;
      }
    }

    apples.removeWhere((apple) => apple.y > 1.0 || apple.collected);

    // ✅ 10 elma toplanınca bitir
    if (collectedCount >= 10 && !gameOver) {
      gameOver = true;
      disposeGame();
      onGameOver();
      notifyListeners();
    }

    notifyListeners();
  }

  void moveBasket(double localDx, double screenWidth) {
    basketX = (localDx / screenWidth).clamp(0.0, 1.0);
    notifyListeners();
  }
}

class FallingApple {
  int value;
  double x;
  double y;
  double speed;
  bool collected;

  FallingApple({
    required this.value,
    required this.x,
    required this.y,
    required this.speed,
    this.collected = false,
  });
}
