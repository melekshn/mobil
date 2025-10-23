import 'dart:math';
import 'package:disleksi_surum/view/time_and_yon/days_view.dart';
import 'package:disleksi_surum/viewModel/mevsim_view_model.dart';
import 'package:disleksi_surum/viewModel/tts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SonbaharView extends StatelessWidget {
  const SonbaharView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenw = MediaQuery.sizeOf(context).width;
    double screenh = MediaQuery.sizeOf(context).height;

    // Mevsimleri karıştır
    List<String> mevsim = ['kış', 'yaz', 'sonbahar', 'ilkbahar'];
    mevsim.shuffle(Random());

    return Scaffold(
      body: Container(
        width: screenw,
        height: screenh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: screenw * 0.8,
            height: screenh * 0.8,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/images/mevsim/sonbahar.png', // dosya adını düzelt
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSeasonButton(mevsim[0], 'sonbahar', context),
                      const SizedBox(height: 15),
                      _buildSeasonButton(mevsim[1], 'sonbahar', context),
                      const SizedBox(height: 15),
                      _buildSeasonButton(mevsim[2], 'sonbahar', context),
                      const SizedBox(height: 15),
                      _buildSeasonButton(mevsim[3], 'sonbahar', context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeasonButton(String label, String dogruCevap, BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              final vm = Provider.of<MevsimViewModel>(context,listen: false);
              vm.kontrol(label, dogruCevap);

              if (vm.iskontrol) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TimeTrainScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade200,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.orange, width: 2),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final tts = Provider.of<TtsViewModel>(context, listen: false);
            tts.speak(label);
          },
          icon: const Icon(Icons.volume_up, size: 30, color: Colors.orange),
        ),
      ],
    );
  }
}