import 'dart:math';
import 'package:disleksi_surum/view/ortak_bosluk/agac.dart';
import 'package:disleksi_surum/viewModel/farklibul_view_model.dart';
import 'package:disleksi_surum/viewModel/game_result_viewmodel.dart';
import 'package:disleksi_surum/viewModel/game_timer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/list.dart';
import 'yonerge.dart';

class PDers3 extends StatefulWidget {
  final String harf;
  final List<String> img;

  const PDers3({super.key, required this.harf, required this.img});

  @override
  State<PDers3> createState() => _PDers3State();
}

class _PDers3State extends State<PDers3> {
  late List<String> shuffledImages;

  @override
  void initState() {
    super.initState();

    // Listeyi karıştırıyoruz
    shuffledImages = List<String>.from(widget.img);
    shuffledImages.shuffle(Random());

    // Timer başlat
    final timerVM = Provider.of<GameTimerViewModel>(context, listen: false);
    timerVM.reset();
    timerVM.startTimer();
  }

  @override
  void dispose() {
    // Timer durdur
    final timerVM = Provider.of<GameTimerViewModel>(context, listen: false);
    timerVM.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthscreen = MediaQuery.sizeOf(context).width;
    final heightscreen = MediaQuery.sizeOf(context).height;
    final isLandscape = widthscreen > heightscreen;

    // Harfe göre listeyi al
    final secilenListe = tumListeler[widget.harf.toUpperCase()];
    if (secilenListe == null) {
      debugPrint("HATA: '${widget.harf}' için liste bulunamadı!");
      return const Scaffold(
        body: Center(child: Text("Liste bulunamadı.")),
      );
    }

    final harfList = List<String>.from(secilenListe[1]['list']);
    final hedefHarf = secilenListe[1]['harf'] as String;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: widthscreen,
          height: heightscreen,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (colIndex) {
                      int index = rowIndex * 3 + colIndex;

                      if (index >= shuffledImages.length) return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: widthscreen / 5,
                          height: widthscreen / 5,
                          child: GestureDetector(
                            onTap: () async {
                              final vm = Provider.of<FarkliBulViewModel>(context, listen: false);
                              vm.kontrolEt(shuffledImages[index], widget.harf);

                              if (vm.isCorrect) {
                                // Oyun doğru tamamlandı
                                final timerVM = Provider.of<GameTimerViewModel>(context, listen: false);
                                timerVM.stopTimer();

                                final vm2 = Provider.of<GameResultViewModel>(context, listen: false);
                                await vm2.saveGameResult(
                                  letter: widget.harf,
                                  totalClicks: vm.totalClicks,
                                  correctClicks: vm.correctClicks,
                                  durationseconds: timerVM.totalSeconds,
                                    koleksiyonadi: 'Harfler'
                                );

                                // Sonraki sayfaya geçiş
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Yonerge(
                                      text: 'Ağaçtan elma topla!',
                                      page: HarfToplaPage(
                                        hedefHarf: hedefHarf,
                                        harfListesi: harfList,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/harfler/P/farklı_${shuffledImages[index]}.jpeg',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔠 Harf listeleri burada tanımlı
final Map<String, List<Map<String, dynamic>>> tumListeler = {
  'P': pliste,
  'D': dliste,
  'B': bliste,
  'U': uliste,
  'M': mliste,
  'N': nliste,
};
