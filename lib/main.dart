import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/database/cek_db_table_helper.dart';
import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:manajemen_keuangan/presentation/pages/dashboard_page.dart';
import 'package:manajemen_keuangan/presentation/pages/kategori_page.dart';
// import 'package:manajemen_keuangan/presentation/pages/PageHome.dart';
import 'package:manajemen_keuangan/presentation/pages/login_page.dart';
import 'package:manajemen_keuangan/presentation/pages/notfound_page.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/presentation/pages/home_page.dart';
import 'package:manajemen_keuangan/presentation/pages/user_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Buat database & tabel
  DbHelper.database;
  cekDb();

  runApp(MyApp());
}

void cekDb() async {
  final tables = await CekDbTableHelper.getTables();
  print("Daftar tabel: $tables");

  for (var table in tables) {
    final columns = await CekDbTableHelper.getTableInfo(table);
    print("Struktur tabel $table: $columns");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Manajemen Keuangan",
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/kategori': (context) => KategoriPage(),
        '/user': (context) => UserPage(),
      },
      debugShowCheckedModeBanner: false,
      // color: Colors.white,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      themeMode: ThemeMode.system,
      themeAnimationCurve: Curves.decelerate,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const NotfoundPage()),
    );
  }
}
