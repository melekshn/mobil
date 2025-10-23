import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/sagsol_view_model.dart';

class LeftRightGamePage extends StatelessWidget {
  const LeftRightGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LeftRightViewModel>(
        builder: (context, viewModel, _) {
          final screenWidth = MediaQuery.of(context).size.width;
          final maxPosition = screenWidth - viewModel.boxWidth - 20;

          return Stack(
            children: [
              // 🍯 Bal kavanozu (hedef)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: 200,
                left: viewModel.targetPosition,
                child: Container(
                  width: viewModel.boxWidth,
                  height: viewModel.boxWidth,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(3, 3))
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '🍯',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),

              // 🐻 Karakter
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: 200,
                left: viewModel.characterPosition,
                child: Container(
                  width: viewModel.boxWidth,
                  height: viewModel.boxWidth,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(3, 3))
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '🐻',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),

              // 🗨 Hikaye balonu
              Positioned(
                top: 40,
                left: 120,
                right: 120,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4)
                    ],
                  ),
                  child: Text(
                    viewModel.storyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // 🎮 Kontrol butonları
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: viewModel.moveLeft,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        icon: const Icon(Icons.arrow_left, size: 32),
                        label: const Text(
                          'Sola Git',
                          style:
                          TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => viewModel.moveRight(maxPosition),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        icon: const Icon(Icons.arrow_right, size: 32),
                        label: const Text(
                          'Sağa Git',
                          style:
                          TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}