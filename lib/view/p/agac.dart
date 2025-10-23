import 'package:disleksi_surum/view/p/balon_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../viewModel/agac_view_model.dart';

class HarfToplaPage extends StatefulWidget {
  final String hedefHarf;
  final List<String> harfListesi;

  const HarfToplaPage({
    super.key,
    required this.hedefHarf,
    required this.harfListesi,
  });

  @override
  State<HarfToplaPage> createState() => _HarfToplaPageState();
}

class _HarfToplaPageState extends State<HarfToplaPage> {

  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde listeyi set et
    Future.microtask(() {
      final viewModel = context.read<agacViewModel>();
      viewModel.setTextList(widget.harfListesi, widget.hedefHarf);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.sizeOf(context).width;
    double heightscreen = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.yesil,
      body: Consumer<agacViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.textlist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          bool allCollected = viewModel.textlist
              .asMap()
              .entries
              .where((e) => e.value.toLowerCase() == viewModel.hedefHarf)
              .every((e) => !viewModel.visibleList[e.key]);

          if (allCollected) {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HarfBulPage(hedefHarf: 'p', harfListesi: ['p', 'b', 'd', 'p', 'b', 'd', 'd', 'p', 'b', 'p', 'p'],)),
              );
            });
          }

          final List<Offset> positions = [
            Offset(widthscreen * 0.2, heightscreen * 0.015),
            Offset(widthscreen * 0.3, heightscreen * 0.025),
            Offset(widthscreen * 0.5, heightscreen * 0.055),
            Offset(widthscreen * 0.7, heightscreen * 0.035),
            Offset(widthscreen * 0.20, heightscreen * 0.18),
            Offset(widthscreen * 0.28, heightscreen * 0.22),
            Offset(widthscreen * 0.35, heightscreen * 0.20),
            Offset(widthscreen * 0.55, heightscreen * 0.20),
            Offset(widthscreen * 0.65, heightscreen * 0.22),
            Offset(widthscreen * 0.72, heightscreen * 0.22),
            Offset(widthscreen * 0.75, heightscreen * 0.1),
          ];

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFBFECFF),
                  Color(0xFF7BD3EA),
                  Color(0xFFECFAE5),
                  Color(0xFFDDF6D2),
                  Color(0xFFA3DC9A),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/tree.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // 🍎 Elmalar
                ...List.generate(viewModel.textlist.length, (index) {
                  if (index >= positions.length) return const SizedBox();
                  final pos = positions[index];

                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: Visibility(
                      visible: viewModel.visibleList[index],
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: GestureDetector(
                        onTap: () => viewModel.addIfMatch(index),
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/elma.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              viewModel.textlist[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}