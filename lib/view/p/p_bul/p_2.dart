import 'dart:math';
import 'package:disleksi_surum/view/p/p_bosluk/p_ders1.dart';
import 'package:disleksi_surum/viewModel/fonem_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../viewModel/tts_view_model.dart';

class PDers2 extends StatelessWidget {
  final String targetLetter; // 🔹 Hedef harf (ör: 'P')
  final String instructionText; // 🔹 Yönerge metni
  final List<String> imageNames; // 🔹 Gösterilecek görseller listesi

  const PDers2({
    super.key,
    required this.targetLetter,
    required this.instructionText,
    required this.imageNames,
  });

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.sizeOf(context).width;
    double heightscreen = MediaQuery.sizeOf(context).height;

    // 🔹 Listeyi karıştır
    List<String> shuffledImages = List.of(imageNames)..shuffle(Random());

    // 🔹 Görselleri önceden belleğe al
    for (var img in shuffledImages) {
      precacheImage(
        AssetImage(
          'assets/harfler/${img[1].toUpperCase()}/$img.jpeg',
        ),
        context,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.lila,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widthscreen * 0.9,
                  maxHeight: heightscreen * 0.9,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (var img in shuffledImages)
                            _buildMenuButton(
                              context,
                              imagePath: img.endsWith(targetLetter.toLowerCase())
                                  ? 'assets/harfler/$targetLetter/$img.jpeg'
                                  : 'assets/harfler/D/$img.jpeg',
                              widthscreen: widthscreen,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        instructionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'RegularFont',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      IconButton(
                        onPressed: () {
                          final vm = Provider.of<TtsViewModel>(context, listen: false);
                          vm.speak(instructionText);
                        },
                        icon: const Icon(
                          Icons.volume_up,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required String imagePath,
        required double widthscreen,
      }) {
    final vm = Provider.of<FonemViewModel>(context);
    return SizedBox(
      width: widthscreen / 4.2,
      height: widthscreen / 4.2,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            vm.Kontrol2('P', imagePath.split('/').last);
            if (vm.kontrol2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PHarfiSayfaKontrol(),
                ),
              );
            }
          },
          splashColor: const Color.fromRGBO(255, 255, 255, 0.2),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}