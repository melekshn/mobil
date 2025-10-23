import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/days_view_model.dart';

class TrainVagon extends StatelessWidget {
  final TimeCategory category;
  final String label;
  final Color color;
  final List<ActivityCard> placedCards;

  const TrainVagon({
    required this.category,
    required this.label,
    required this.color,
    required this.placedCards,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TimeTrainViewModel>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final vagonHeight = screenHeight / 4;

    return DragTarget<ActivityCard>(
      onAcceptWithDetails: (details) {
        final card = details.data;
        if (vm.handleCardDrop(card, category)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("🎉 ${card.title} doğru yere yerleştirildi!"),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 220,
          height: vagonHeight,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: candidateData.isNotEmpty ? Colors.yellowAccent : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              const Divider(color: Colors.white70),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: placedCards
                        .map((card) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Chip(
                        label: Text(card.title,
                            style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.white,
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimeTrainScreen extends StatelessWidget {
  const TimeTrainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeTrainViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3E9DC),
        body: SafeArea(
          child: Consumer<TimeTrainViewModel>(
            builder: (context, vm, child) {
              if (vm.isGameComplete) {
                vm.speak("Tebrikler! Tüm kartları doğru yerleştirdin. Sen bir zaman ustasısın!");
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "🎉 Oyun Bitti! Harikasın!",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isSmallScreen = constraints.maxWidth < 600;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Flex(
                          direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- SOL: TREN VAGONLARI ---
                            Expanded(
                              flex: isSmallScreen ? 0 : 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TrainVagon(
                                    category: TimeCategory.YESTERDAY,
                                    label: "DÜN",
                                    color: const Color(0xFFFAB12F),
                                    placedCards: vm.placedYesterday,
                                  ),
                                  TrainVagon(
                                    category: TimeCategory.TODAY,
                                    label: "BUGÜN",
                                    color: const Color(0xFFFA812F),
                                    placedCards: vm.placedToday,
                                  ),
                                  TrainVagon(
                                    category: TimeCategory.TOMORROW,
                                    label: "YARIN",
                                    color: const Color(0xFFDD0303),
                                    placedCards: vm.placedTomorrow,
                                  ),
                                ],
                              ),
                            ),
                            if (!isSmallScreen)
                              const SizedBox(width: 16)
                            else
                              const SizedBox(height: 16),
                            // --- SAĞ: KARTLAR ---
                            Expanded(
                              flex: isSmallScreen ? 0 : 6,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isSmallScreen ? 1 : 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2.5,
                                ),
                                itemCount: vm.draggableCards.length,
                                itemBuilder: (context, index) {
                                  final card = vm.draggableCards[index];
                                  return Draggable<ActivityCard>(
                                    data: card,
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: Chip(
                                        label: Text(card.title,),
                                        backgroundColor: Colors.yellow.shade200,
                                      ),
                                    ),
                                    childWhenDragging: Chip(
                                      label: Text(card.title,),
                                      backgroundColor: Colors.yellow.shade100,
                                    ),
                                    child: Chip(
                                      label: Text(card.title,style: TextStyle(fontSize: 18)),
                                      backgroundColor: const Color(0xFFFEF3E2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
