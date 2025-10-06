import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/core/database/cek_db_table_helper.dart';
import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:manajemen_keuangan/presentation/pages/anggota_page.dart';
import 'package:manajemen_keuangan/presentation/pages/dashboard_page.dart';
import 'package:manajemen_keuangan/presentation/pages/kategori_page.dart';
import 'package:manajemen_keuangan/presentation/pages/login_page.dart';
import 'package:manajemen_keuangan/presentation/pages/notfound_page.dart';
import 'package:manajemen_keuangan/presentation/pages/home_page.dart';
import 'package:manajemen_keuangan/presentation/pages/profile_page.dart';
import 'package:manajemen_keuangan/presentation/pages/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Buat database & tabel
  DbHelper.database;
  cekDb();

  final prefs = await SharedPreferences.getInstance();

  // kalau pakai flag bool
  final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  // kalau pakai simpan user JSON
  // final isLoggedIn = prefs.getString("user") != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
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
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Manajemen Keuangan",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      themeMode: ThemeMode.system,
      themeAnimationCurve: Curves.decelerate,

      // Halaman awal ditentukan berdasarkan login
      home: isLoggedIn ? const DashboardPage() : const HomePage(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/kategori': (context) => const KategoriPage(),
        '/user': (context) => const UserPage(),
        '/profile': (context) => const ProfilePage(),
        '/anggota': (context) => const AnggotaPage(),
      },

      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const NotfoundPage()),
    );
  }
}
