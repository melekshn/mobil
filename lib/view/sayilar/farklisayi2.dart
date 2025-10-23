import 'dart:math';
import 'package:disleksi_surum/view/sayilar/card_sayi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/farklibul_view_model.dart';

class SayiFark2 extends StatelessWidget {

  const SayiFark2({super.key});

  @override
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.sizeOf(context).width;
    double heightscreen = MediaQuery.sizeOf(context).height;

    List<String> img = ['0','8','8','8','8','8'];
    img.shuffle(Random());

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
            child: SingleChildScrollView(  // taşmayı engeller
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (rowIndex) { // 2 satır
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (colIndex) { // 3 sütun
                      int index = rowIndex * 3 + colIndex; // 2x3 matris için index
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: widthscreen / 5,
                          height: widthscreen / 5,
                          child: GestureDetector(
                            onTap: () {
                              final vm = Provider.of<FarkliBulViewModel>(context,listen: false);
                              vm.Kontrol(img[index],'0');
                              if(vm.kontrol){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>  CardPage(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/sayilar/sayi_${img[index]}.jpeg'
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
