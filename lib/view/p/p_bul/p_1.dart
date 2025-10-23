import 'dart:math';
import 'package:disleksi_surum/view/p/p_bul/p_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../viewModel/fonem_view_model.dart';
import '../../../viewModel/tts_view_model.dart';

class PDers1 extends StatelessWidget {
  final String hedefHarf;
  final List<String> dogruHarfResimleri; // hedef harf ile başlayanlar
  final List<String> digerHarfResimleri; // karıştırıcı resimler
  final Color arkaPlanRengi;
  final String arkaPlanResmiYolu;
  final String mesaj;

  const PDers1({
    super.key,
    required this.hedefHarf,
    required this.dogruHarfResimleri,
    required this.digerHarfResimleri,
    this.arkaPlanRengi = AppColors.lila,
    this.arkaPlanResmiYolu = 'assets/images/background.png',
    required this.mesaj,
  });

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.sizeOf(context).width;
    double heightscreen = MediaQuery.sizeOf(context).height;

    // 🔹 Resimleri karıştır
    final allImages = [...dogruHarfResimleri, ...digerHarfResimleri]..shuffle(Random());

    return Scaffold(
      backgroundColor: arkaPlanRengi,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(arkaPlanResmiYolu),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                            for (var img in allImages)
                              _buildImageButton(
                                context,
                                img,
                                hedefHarf,
                                widthscreen,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          mesaj,
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
                            Provider.of<TtsViewModel>(context, listen: false)
                                .speak(mesaj);
                          },
                          icon: const Icon(Icons.volume_up,
                              color: Colors.orange, size: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton(
      BuildContext context, String img, String hedefHarf, double widthscreen) {
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
            vm.Kontrol(hedefHarf, img);
            debugPrint(img);
            if (vm.kontrol) {
             Navigator.push(context, 
                 MaterialPageRoute(builder: (_)=>
                     PDers2(imageNames: ['corap','radyo','kardanadam'],
                       instructionText: 'İçinde P harfi olan resme tıkla',
                       targetLetter: 'P',))
             );
            }
          },
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
              child: Image.asset(
                'assets/harfler/${img[0].toUpperCase()}/$img.jpeg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}