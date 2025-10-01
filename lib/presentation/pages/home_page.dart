import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image + Gradient Overlay
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(color: Color(ColorCustom.ColorLight)),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon dengan animasi floating halus
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: -10, end: 10),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  builder: (context, double offset, child) {
                    return Transform.translate(
                      offset: Offset(0, offset),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    '${PathImage.backgrounds}back1.png',
                    width: 400,
                  ),
                ),
                const SizedBox(height: 24),

                // Subtitle
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Aplikasi Manajemen Keuangan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(221, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol Mulai modern
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.black45,
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Mulai",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
