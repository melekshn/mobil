import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/apple_number_game_viewmodel.dart';
import '../../viewModel/eggviewmodel.dart';
import 'egg_input_page.dart';

class AppleNumberGame extends StatefulWidget {
  const AppleNumberGame({Key? key}) : super(key: key);

  @override
  State<AppleNumberGame> createState() => _AppleNumberGameState();
}

class _AppleNumberGameState extends State<AppleNumberGame> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = context.read<AppleViewModel>();
      vm.startGame(() {
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
          create: (_) => EggInputViewModel(),
          child: const EggInputPage(),
        ),
        ),);
      });
    });
  }

  @override
  void dispose() {
    context.read<AppleViewModel>().disposeGame();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppleViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: GestureDetector(
        onPanUpdate: (details) => vm.moveBasket(details.localPosition.dx, size.width),
        child: Stack(
          children: [
            // 🍎 Düşen sayılı elmalar
            ...vm.apples.map((apple) => Positioned(
              top: apple.y * size.height,
              left: apple.x * size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/elma.png', width: 40, height: 40),
                  Text(
                    "${apple.value}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),

            // 🧺 Sepet
            Positioned(
              bottom: 0,
              left: vm.basketX * size.width - 45,
              child: Image.asset(
                'assets/images/sayilar/sepet.jpeg',
                width: 200,
                height: 150,
              ),
            ),

            // 🧮 Skor ve Sayaç
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                "Skor: ${vm.score}   🍎: ${vm.collectedCount}/10",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
