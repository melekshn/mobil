import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/tts_view_model.dart';

class Yonerge extends StatelessWidget {
  final String text;
  final Widget page;
  final ChangeNotifier Function()? pagevm;

  const Yonerge({
    super.key,
    required this.text,
    required this.page,
    this.pagevm,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TtsViewModel>(context, listen: false);
    final widthscreen = MediaQuery.sizeOf(context).width;
    final heightscreen = MediaQuery.sizeOf(context).height;
    final isLandscape = widthscreen > heightscreen;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: widthscreen,
          height: heightscreen,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: isLandscape ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: isLandscape ? 4 : 3,
                    child: Image.asset(
                      'assets/images/karakter.jpeg',
                      height: isLandscape
                          ? heightscreen * 0.8
                          : heightscreen * 0.35,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16, height: 16),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(220),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(3, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontFamily: 'OpenDyslexic',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          IconButton(
                            onPressed: () async {
                              await vm.speak(text);

                              // Konuşma tamamlanınca sayfaya git
                              Future.delayed(const Duration(seconds: 5), () {
                                // 🔽 Sayfayı Provider ile sar
                                Widget nextPage = pagevm == null
                                    ? page
                                    : ChangeNotifierProvider(
                                  create: (_) => pagevm!(),
                                  child: page,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => nextPage),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.volume_up,
                              color: Colors.orange,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/tts_view_model.dart';
import '../../viewModel/userget_view_model.dart';
import '../../models/users_models.dart';

class Yonerge extends StatelessWidget {
  final String text;
  final Widget page;
  final ChangeNotifier Function()? pagevm;

  const Yonerge({
    super.key,
    required this.text,
    required this.page,
    this.pagevm,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TtsViewModel>(context, listen: false);
    final widthscreen = MediaQuery.sizeOf(context).width;
    final heightscreen = MediaQuery.sizeOf(context).height;
    final isLandscape = widthscreen > heightscreen;
    final uvm = Provider.of<UserGetViewModel>(context, listen: false);

    return FutureBuilder<Users?>(
      future: uvm.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Kullanıcı bulunamadı"));
        }

        final user = snapshot.data!;
        final karakter = user.avatarUrl;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              width: widthscreen,
              height: heightscreen,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Flex(
                    direction: isLandscape ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: isLandscape ? 4 : 3,
                        child: karakter.isNotEmpty
                            ? Image.network(
                                karakter,
                                height: isLandscape
                                    ? heightscreen * 0.8
                                    : heightscreen * 0.35,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'assets/images/default_avatar.png',
                                height: isLandscape
                                    ? heightscreen * 0.8
                                    : heightscreen * 0.35,
                                fit: BoxFit.contain,
                              ),
                      ),
                      const SizedBox(width: 16, height: 16),
                      Flexible(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(220),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(3, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontFamily: 'RegularFont',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              IconButton(
                                onPressed: () async {
                                  await vm.speak(text);

                                  Future.delayed(const Duration(seconds: 5), () {
                                    Widget nextPage = pagevm == null
                                        ? page
                                        : ChangeNotifierProvider(
                                            create: (_) => pagevm!(),
                                            child: page,
                                          );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => nextPage),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.volume_up,
                                  color: Colors.orange,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
*/
