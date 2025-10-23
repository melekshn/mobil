import 'package:flutter/material.dart';

class HouseViewModel extends ChangeNotifier {
  Color wallColor = Colors.white;
  Color roofColor = Colors.white;
  Color doorColor = Colors.white;
  Color treeColor = Colors.white;
  Color windowColor = Colors.white; // pencere rengi

  int? selectedNumber;

  final Map<int, Color> numberColors = {
    0: Color(0xffF75270), // duvar
    8: Color(0xffEB5B00),     // çatı
    3: Colors.amber,      // kapı
    9: Colors.lightGreen, // ağaç
    7: Color(0xff78C841),  // pencere
  };

  void selectNumber(int number) {
    selectedNumber = number;
    notifyListeners();
  }

  void handleTap(Offset pos, Size size, VoidCallback onAllColored) {
    final wallRect = Rect.fromLTWH(80, 180, 240, 200);
    final roofPath = Path()
      ..moveTo(200, 80)
      ..lineTo(60, 180)
      ..lineTo(340, 180)
      ..close();
    final doorRect = Rect.fromLTWH(180, 280, 40, 100);
    final treeRect = Rect.fromLTWH(350, 220, 40, 120);
    final windowRect = Rect.fromLTWH(120, 220, 40, 60); // pencere

    if (selectedNumber == 0 && wallRect.contains(pos)) wallColor = numberColors[0]!;
    else if (selectedNumber == 8 && _isPointInPath(pos, roofPath)) roofColor = numberColors[8]!;
    else if (selectedNumber == 3 && doorRect.contains(pos)) doorColor = numberColors[3]!;
    else if (selectedNumber == 9 && treeRect.contains(pos)) treeColor = numberColors[9]!;
    else if (selectedNumber == 7 && windowRect.contains(pos)) windowColor = numberColors[7]!;

    notifyListeners();

    if (_isAllColored()) onAllColored();
  }

  bool _isAllColored() {
    return wallColor == numberColors[0]! &&
        roofColor == numberColors[8]! &&
        doorColor == numberColors[3]! &&
        treeColor == numberColors[9]! &&
        windowColor == numberColors[7]!;
  }

  bool _isPointInPath(Offset point, Path path) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      final subPath = metric.extractPath(0, metric.length);
      if (subPath.getBounds().contains(point)) return true;
    }
    return false;
  }
}
