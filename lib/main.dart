import 'package:disleksi_surum/view/login.dart';
import 'package:disleksi_surum/viewModel/agac_view_model.dart';
import 'package:disleksi_surum/viewModel/apple_number_game_viewmodel.dart';
import 'package:disleksi_surum/viewModel/asansor_view_model.dart';
import 'package:disleksi_surum/viewModel/balon_view_model.dart';
import 'package:disleksi_surum/viewModel/card_sayi_view_model.dart';
import 'package:disleksi_surum/viewModel/days_view_model.dart';
import 'package:disleksi_surum/viewModel/farklibul_view_model.dart';
import 'package:disleksi_surum/viewModel/fonem_view_model.dart';
import 'package:disleksi_surum/viewModel/game_view_model.dart';
import 'package:disleksi_surum/viewModel/harfsecviewmodel.dart';
import 'package:disleksi_surum/viewModel/mevsim_view_model.dart';
import 'package:disleksi_surum/viewModel/register_view_model.dart';
import 'package:disleksi_surum/viewModel/sagsol_view_model.dart';
import 'package:disleksi_surum/viewModel/themeNotifier_view_model.dart';
import 'package:disleksi_surum/viewModel/tts_view_model.dart';
import 'package:disleksi_surum/viewModel/userget_view_model.dart';
import 'package:disleksi_surum/viewModel/usersinfo_viewmodel.dart';
import 'package:disleksi_surum/viewModel/video_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AvatarViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => TtsViewModel()),
        ChangeNotifierProvider(create: (_)=>VideoViewModel()),
        ChangeNotifierProvider(create: (_)=>FonemViewModel()),
        ChangeNotifierProvider(create: (_)=>SecViewModel()),
        ChangeNotifierProvider(create: (_)=>agacViewModel()),
        ChangeNotifierProvider(create: (_)=>GameViewModel()),
        ChangeNotifierProvider(create: (_)=>UserGetViewModel()),
        ChangeNotifierProvider(create: (_)=>MevsimViewModel()),
        ChangeNotifierProvider(create: (_)=>TimeTrainViewModel()),
        ChangeNotifierProvider(create: (_)=>AsansorViewModel()),
        ChangeNotifierProvider(create: (_)=>LeftRightViewModel()),
        ChangeNotifierProvider(create: (_)=>FarkliBulViewModel()),
        ChangeNotifierProvider(create: (_)=>CardViewModel()),
        ChangeNotifierProvider(create: (_)=>AppleViewModel()),
        ChangeNotifierProvider(create: (_)=>BalonViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'OpenDyslexic',
            primaryColor: themeNotifier.currentTheme.primaryColor,
            hintColor: themeNotifier.currentTheme.secondaryColor,
          ),
          home: const LoginPage(),
        );
      },
    );
  }
}
