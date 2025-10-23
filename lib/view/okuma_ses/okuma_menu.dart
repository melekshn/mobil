import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/hikayeler.dart';
import 'okuma.dart';

class ColorfulTextPage extends StatefulWidget {
  const ColorfulTextPage({super.key});

  @override
  State<ColorfulTextPage> createState() => _ColorfulTextPageState();
}

class _ColorfulTextPageState extends State<ColorfulTextPage> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFAA80),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFAA80),
        title: const Text("Bunları Biliyor Musun ?"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingPage(storyIndex: index),
                ),
              );
            },
            child: Card(
              color: const Color(0xFF48B3AF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/soru.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    story.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
