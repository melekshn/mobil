import 'package:disleksi_surum/utils/colors.dart';
import 'package:disleksi_surum/view/p/agac.dart';
import 'package:disleksi_surum/view/p/balon_view.dart';
import 'package:disleksi_surum/view/p/farkli_bul.dart';
import 'package:disleksi_surum/view/p/p_bosluk/p_ders1.dart';
import 'package:disleksi_surum/view/p/p_bul/p_1.dart';
import 'package:disleksi_surum/view/p/p_animation.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildHomeButton(context, 'Harf İzle', Icons.abc, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PStart(
                          video: 'assets/harfler/P/p.mp4',
                          hedef: 'P',
                          dogrulink: ['peynir'],
                          linkler: ['domates','dkardanadam',],
                          mesaj: 'P harfi ile başlayan resme tıkla',
                        ),
                      ),
                    );
                  }),
                  _buildHomeButton(context, 'P Avcısı', Icons.search, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PDers1(hedefHarf: "p",
                          dogruHarfResimleri: ['peynir',],
                          digerHarfResimleri:
                          ['yıldız',
                            'domates'],
                        mesaj: "P harfi ile başlayan resme tıkla",),
                      ),
                    );
                  }),
                  _buildHomeButton(context, 'P mi B mi ?', Icons.question_mark, () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PHarfiSayfaKontrol(),
                      ),
                    );
                  }),
                  _buildHomeButton(context, 'Farklı olanı bul!', Icons.priority_high, () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PDers3(),
                      ),
                    );
                  }),
                  _buildHomeButton(context, 'Ağaçtan elma topla!', Icons.touch_app, (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HarfToplaPage(hedefHarf: "p", harfListesi: ['p', 'b', 'd', 'p', 'b', 'd', 'd', 'p', 'b', 'p', 'p'],),
                      ),
                    );
                  }),
                  _buildHomeButton(context, 'Balon Oyunu!', Icons.touch_app, (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HarfBulPage(hedefHarf: 'p', harfListesi: ['p', 'b', 'd', 'g', 'b', 'b', 'd', 'd', 'p','p'],)
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.mavi),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}