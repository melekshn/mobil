import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class AsansorViewModel extends ChangeNotifier {
  final Random _random = Random();

  int _targetFloor = 0;
  int get targetFloor => _targetFloor;

  int _currentFloor = 5; // Başlangıç: zemin kat
  double _elevatorPosition = 0.0;

  final double _floorHeight = 80.0;
  final double _storyBoxHeight = 100.0;
  final List<double> _floorPositions = [];

  List<String> _storySteps = [];
  List<int> _storyTargetFloors = [];
  int _currentStep = 0;

  double get elevatorPosition => _elevatorPosition;
  int get currentFloor => _currentFloor;
  String get storyText => _storySteps[_currentStep];
  List<double> get floorPositions => _floorPositions;

  double get storyBoxHeight => _storyBoxHeight;
  double get floorHeight => _floorHeight;

  double getFloorPosition(int floorIndex) {
    return _storyBoxHeight + 20.0 + floorIndex * _floorHeight;
  }

  AsansorViewModel() {
    _init(); // floorPositions burada dolacak
    _storySteps = generateRandomStorySteps(3);
    _storyTargetFloors = List.generate(_storySteps.length, (_) => _random.nextInt(6));
    _currentStep = 0;
    _targetFloor = _storyTargetFloors[_currentStep];
    _elevatorPosition = _floorPositions[_currentFloor];
  }

  void _init() {
    for (int i = 0; i < 6; i++) {
      _floorPositions.add(_storyBoxHeight + 20.0 + i * _floorHeight);
    }
    _elevatorPosition = _floorPositions[_currentFloor];
  }

  List<String> generateRandomStorySteps(int count) {
    List<String> steps = [];
    for (int i = 0; i < count; i++) {
      int current = _random.nextInt(6);
      int target;
      do {
        target = _random.nextInt(6);
      } while (target == current);

      steps.add("Arkadaşımız şu anda ${5 - current}. katta. "
          "Hedef ${5 - target}. kat!");
    }
    return steps;
  }
  void moveUp() {
    if (_floorPositions.isEmpty) return; // güvenlik kontrolü
    if (_currentFloor > 0) {
      _currentFloor--;
      _elevatorPosition = _floorPositions[_currentFloor];
      notifyListeners();
    }
  }

  void moveDown() {
    if (_floorPositions.isEmpty) return; // güvenlik kontrolü
    if (_currentFloor < _floorPositions.length - 1) {
      _currentFloor++;
      _elevatorPosition = _floorPositions[_currentFloor];
      notifyListeners();
    }
  }



  void checkIfAtTarget(BuildContext context) {
    if (_currentFloor == _targetFloor) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "🎉 Doğru! Hedef kata ulaştın: ${5 - _targetFloor}. kat",
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Hikaye adımını ilerlet
      if (_currentStep < _storySteps.length - 1) {
        _currentStep++;
        _targetFloor = _storyTargetFloors[_currentStep];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🏁 Tüm hikaye adımları tamamlandı!"),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "❌ Henüz hedef katta değilsin! Şu an ${5 - _currentFloor}. kattasın."),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }
}
