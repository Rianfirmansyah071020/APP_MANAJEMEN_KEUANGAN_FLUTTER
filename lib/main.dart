import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/Pages/PageDashboard.dart';
import 'package:manajemen_keuangan/Pages/PageHome.dart';
import 'package:manajemen_keuangan/Pages/PageLogin.dart';
import 'package:manajemen_keuangan/Pages/PageNotFound.dart';
import 'package:manajemen_keuangan/components/PathImage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Manajemen Keuangan",
      initialRoute: '/',
      routes: {
        '/login': (context) => PageLogin(),
        '/dashboard': (context) => Pagedashboard(),
      },
      debugShowCheckedModeBanner: false,
      // color: Colors.white,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PageHome(),
      themeMode: ThemeMode.system,
      themeAnimationCurve: Curves.decelerate,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const PageNotFound()),
    );
  }
}
