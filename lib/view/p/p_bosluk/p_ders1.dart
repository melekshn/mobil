import 'package:disleksi_surum/view/p/farkli_bul.dart';
import 'package:flutter/material.dart';
import '../../../utils/p_harf.dart';
import '../../ortak_bosluk/harf_sec_page.dart';
import '../../ortak_bosluk/yonerge.dart';

class PHarfiSayfaKontrol extends StatefulWidget {
  const PHarfiSayfaKontrol({super.key});

  @override
  State<PHarfiSayfaKontrol> createState() => _PHarfiSayfaKontrolState();
}

class _PHarfiSayfaKontrolState extends State<PHarfiSayfaKontrol> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    if (index >= pKelimeListesi.length) {
      return const Center(child: Text("Tebrikler! Tüm P kelimelerini tamamladın 🎉"));
    }

    final veri = pKelimeListesi[index];

    return HarfSecSayfa(
      resimYolu: veri['resim'],
      dogruHarf: veri['dogruHarf'],
      kelime: veri['kelime'],
      tam: veri['tam'],
      sonrakiSayfa: PHarfiSayfaKontrolSonraki(
        sonrakiIndex: index + 1,
      ),
    );
  }
}

class PHarfiSayfaKontrolSonraki extends StatelessWidget {
  final int sonrakiIndex;
  const PHarfiSayfaKontrolSonraki({super.key, required this.sonrakiIndex});

  @override
  Widget build(BuildContext context) {
    final veri = pKelimeListesi[sonrakiIndex];

    return HarfSecSayfa(
      resimYolu: veri['resim'],
      dogruHarf: veri['dogruHarf'],
      kelime: veri['kelime'],
      tam: veri['tam'],
      sonrakiSayfa: sonrakiIndex + 1 < pKelimeListesi.length
          ? PHarfiSayfaKontrolSonraki(sonrakiIndex: sonrakiIndex + 1)
          : Yonerge(text: 'Farklı olanı bul!', page: const PDers3()),
    );
  }
}
