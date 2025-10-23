import 'package:disleksi_surum/view/p/menu_view.dart';
import 'package:flutter/material.dart';

import 'd/menu_view.dart';

class HarflerPage extends StatelessWidget {
  const HarflerPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.sizeOf(context).width;
    double heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Color(0xFFFFEAEA),
      //appBar: AppBar(
       // backgroundColor: AppColors.mavi,),
      body: Container(
        width: widths,
        height: heights,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffBBDCE5),
              //Color(0xffDBC4F0),
              Color(0xffFFC6C6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.count(
            crossAxisCount: 3, // 3 sütun
            crossAxisSpacing: 8.0, // yatay boşluk
            mainAxisSpacing: 4.0, // dikey boşluk
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            children: [
              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/P/p.jpeg',
                label: 'P Harfi',
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => MenuView()),);
                },
              ),
              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/D/d.jpeg',
                label: 'D Harfi',
                onPressed: () {
                 Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => DMenuView()),
                  );
                },
              ),
              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/B/b.jpeg',
                label: 'B Harfi',
                onPressed: () {
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DHarfiSayfaKontrol(),
                    ),
                  );*/
                },
              ),
              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/U/u.jpeg',
                label: 'U Harfi',
                onPressed: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DHarfiSayfaKontrol(),
                    ),
                  );*/
                },
              ),

              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/M/m.jpeg',
                label: 'M Harfi',
                onPressed: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DHarfiSayfaKontrol(),
                    ),
                  );*/
                },
              ),
              _buildMenuButton(
                context,
                imagePath: 'assets/harfler/N/n.jpeg',
                label: 'N Harfi',
                onPressed: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DHarfiSayfaKontrol(),
                    ),
                  );*/
                },
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, {
        required String imagePath,
        required VoidCallback onPressed,
        String? label,
      }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 110,
          height: 130,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onPressed,
            splashColor: const Color.fromRGBO(255, 255, 255, 0.2),
            child: Ink(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}
