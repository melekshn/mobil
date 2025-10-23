import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../viewModel/balon_view_model.dart';

class HarfBulPage extends StatefulWidget {
  final String hedefHarf;
  final List<String> harfListesi;

  const HarfBulPage({
    super.key,
    required this.hedefHarf,
    required this.harfListesi,
  });

  @override
  State<HarfBulPage> createState() => _HarfBulPageState();
}

class _HarfBulPageState extends State<HarfBulPage> {

  @override
  void initState() {
    super.initState();
    // Sayfa açıldığında dikey moda sabitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Sayfa kapanınca tekrar yatay moda al
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.sizeOf(context).width;
    double heightscreen = MediaQuery.sizeOf(context).height;
    return ChangeNotifierProvider<BalonViewModel>(
      create: (_) {
        final vm = BalonViewModel();
        vm.setGame(widget.harfListesi, widget.hedefHarf);
        return vm;
      },
      child: Consumer<BalonViewModel>(
        builder: (context, vm, child) {
          if (vm.tablo.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.pink2,
            body: Stack(
              children: [
                Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(
                            'assets/images/background.png'
                        ),fit: BoxFit.cover)
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: heightscreen/4),
                      Text(
                        'Hadi bakalım ${vm.hedefHarf} harfini bul!',
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const Text(
                        'Balonlarını özgür bırak',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            itemCount: vm.tablo.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemBuilder: (context, index) {
                              final color = vm.renkler[index];
                              return GestureDetector(
                                onTap: () => vm.kontrolEt(index, context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color ?? Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      vm.tablo[index],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            vm.ballon,
                                (index) => Image.asset(
                              'assets/images/ballon.png',
                              width: widthscreen / 7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (vm.showBalloon)
                  AnimatedAlign(
                    duration: const Duration(seconds: 3),
                    alignment: Alignment(0, vm.balloonY),
                    curve: Curves.easeOut,
                    child: SizedBox(
                      width: widthscreen / 2,
                      child: Image.asset('assets/images/ballon.png'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}