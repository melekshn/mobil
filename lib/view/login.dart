import 'package:disleksi_surum/view/home.dart';
import 'package:disleksi_surum/view/register_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double heightscreen = MediaQuery.of(context).size.height;
    final double widthscreen = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Klavye açıldığında kaydırma aktif
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: heightscreen),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Üst kısım boşluk (dinamik hizalama)
                  Expanded(child: Container()),

                  // Alt kısım (Form alanı)
                  Container(
                    width: widthscreen,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(0),
                          Colors.black.withAlpha(180),
                          Colors.black.withAlpha(230),
                          Colors.black.withAlpha(255),
                        ],
                      ),
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          _textField('Kullanıcı adınız:', prefixIcon: Icons.person),
                          const SizedBox(height: 12),
                          _textField(
                            'Şifreniz:',
                            prefixIcon: Icons.lock,
                            suffixIcon: const Icon(Icons.visibility_off, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.check_box_outline_blank,
                                      size: 18, color: Colors.white),
                                  SizedBox(width: 6),
                                  Text('Beni Hatırla',
                                      style: TextStyle(color: Colors.white, fontSize: 15)),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Şifremi Unuttum',
                                    style: TextStyle(color: Colors.blue, fontSize: 15)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              // Giriş yapıldığında yatay moda geç
                              await SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);

                              // Ana sayfaya yönlendir
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const AnasayfaPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text(
                              'GİRİŞ',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hesabın yok mu?',
                                style: TextStyle(
                                    color: Colors.white.withAlpha(150), fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const KayitPage()),
                                  );
                                },
                                child: const Text(
                                  'Kayıt Ol',
                                  style: TextStyle(color: Colors.orange, fontSize: 16),
                                ),
                              ),
                            ],
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

  InputDecoration _decoration(String label,
      {IconData? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
      filled: true,
      fillColor: Colors.white.withAlpha(120),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      prefixIcon: Icon(prefixIcon, color: Colors.black),
      suffixIcon: suffixIcon,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _textField(String label,
      {IconData? prefixIcon, Widget? suffixIcon}) {
    return TextFormField(
      decoration:
      _decoration(label, prefixIcon: prefixIcon, suffixIcon: suffixIcon),
    );
  }
}
