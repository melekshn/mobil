import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'farklisayi.dart';
import '../../utils/house_painter.dart';
import '../../viewModel/house_viewmodel.dart';

class HouseView extends StatelessWidget {
  const HouseView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HouseViewModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Consumer<HouseViewModel>(
            builder: (context, viewModel, _) => Row(
              children: [
                // Sol: ev çizimi
                Expanded(
                  flex: 5,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: GestureDetector(
                        onTapDown: (details) => viewModel.handleTap(
                          details.localPosition,
                          const Size(400, 400),
                              () {
                            // Tüm parçalar boyandı -> başka sayfa
                            Future.delayed(const Duration(seconds: 2), () {

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SayiFark()),
                            );
                            });
                          },
                        ),
                        child: CustomPaint(
                          size: const Size(400, 400),
                          painter: HousePainter(
                            viewModel.wallColor,
                            viewModel.roofColor,
                            viewModel.doorColor,
                            viewModel.treeColor,
                            viewModel.windowColor, // pencere eklendi
                          ),
                        ),

                      ),
                    ),
                  ),
                ),

                // Sağ: palet
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: viewModel.numberColors.entries.map((entry) {
                        final num = entry.key;
                        final color = entry.value;
                        final isSelected = viewModel.selectedNumber == num;

                        return GestureDetector(
                          onTap: () => viewModel.selectNumber(num),
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? Colors.black : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "$num",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
