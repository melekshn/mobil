import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/card_sayi_view_model.dart';
import '../../viewModel/tts_view_model.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ttsvm = Provider.of<TtsViewModel>(context, listen: false);
    final cvm = Provider.of<CardViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔹 Tek seslendirme butonu
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.volume_up, color: Colors.white),
            label: const Text(
              "Sayıları Dinle",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () async {
              // Listeyi sırayla seslendir
              for (String sayi in cvm.numbers) {
                await ttsvm.speak(sayi);
                await Future.delayed(const Duration(seconds: 1)); // kısa bekleme
              }
            },
          ),

          const SizedBox(height: 20),

          // 🔹 Alttaki sabit 0–9 butonları
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(10, (index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Buton $index basıldı');
                  },
                  child: Text('$index'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
