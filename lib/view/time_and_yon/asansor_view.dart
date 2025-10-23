import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/asansor_view_model.dart';
import 'package:flutter/services.dart';

class ElevatorGamePage extends StatelessWidget {
  const ElevatorGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Consumer<AsansorViewModel>(
        builder: (context, vm, child) {
          return Stack(
            children: [
              // Hikaye balonu
              Positioned(
                top: 580,
                left: 20,
                right: 20,
                height: vm.storyBoxHeight,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4)
                    ],
                  ),
                  child: Text(
                    vm.storyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              for (int i = 0; i < 6; i++) ...[
                Positioned(
                  top: vm.getFloorPosition(i),
                  left: 40.0,
                  child: Text(
                    i == 5 ? 'Zemin' : '${6 - i}. Kat',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: vm.getFloorPosition(i) + 30.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
              ],

              // Asansör kabini
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                top: vm.elevatorPosition - 60,
                left: 150.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/asansor.png',
                    width: 160,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 100.0,
                left: 80.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: vm.moveUp,
                      child: const Text('▲ Yukarı', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: vm.moveDown,
                      child: const Text('▼ Aşağı', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                      onPressed: () => vm.checkIfAtTarget(context),
                      child: const Text('✅ Kontrol Et', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),

              ),

            ],
          );
        },
      ),
    );
  }
}