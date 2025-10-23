import 'package:disleksi_surum/view/p/p_bul/p_1.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../viewModel/video_view_model.dart';
import 'package:provider/provider.dart';

class PStart extends StatelessWidget {
  final String video;
  final String hedef;
  final List<String> dogrulink;
  final List<String> linkler;
  final String mesaj;
  const PStart({super.key,required this.video,required this.hedef,required this.dogrulink,required this.linkler,required this.mesaj});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = VideoViewModel();
        vm.initVideo(video);
        return vm;
      },
      child: Consumer<VideoViewModel>(
        builder: (context, vm, child) {
          if (!vm.isInitialized) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Video bittiğinde NextPage’e yönlendir
          if (vm.controller.value.position >=
              vm.controller.value.duration &&
              !vm.controller.value.isPlaying) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PDers1(hedefHarf: hedef,
                    dogruHarfResimleri: dogrulink,
                    digerHarfResimleri:linkler,
                    mesaj: mesaj,),
                ),
              );
            });
          }

          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: AspectRatio(
                aspectRatio: vm.controller.value.aspectRatio,
                child: VideoPlayer(vm.controller),
              ),
            ),
          );
        },
      ),
    );
  }
}