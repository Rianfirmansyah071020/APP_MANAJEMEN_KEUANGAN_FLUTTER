import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';
import 'package:manajemen_keuangan/presentation/controllers/auth_controller.dart';

class TemplatePage extends StatefulWidget {
  final String title;
  final Widget body;

  const TemplatePage({super.key, required this.title, required this.body});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int _selectedIndex = 0;
  final authController = AuthController();

  void _onSelectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi antar halaman
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/kategori');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/anggota');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/user');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // === Logo + Judul ===
            Row(
              children: [
                Image.asset(
                  '${PathImage.icons}icons.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 8),
                Text(widget.title, style: const TextStyle(color: Colors.white)),
              ],
            ),

            // === Avatar dengan Dropdown Menu ===
            PopupMenuButton<String>(
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                if (value == 'profile') {
                  // navigasi ke profile
                  Navigator.pushReplacementNamed(context, '/profile');
                } else if (value == 'logout') {
                  // menampilkan dialog logout
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Apakah anda yakin ingin logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Tidak"),
                        ),
                        TextButton(
                          onPressed: () {
                            authController.logout(context);
                          },
                          child: const Text("Ya"),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text("Profile"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text("Logout"),
                    ],
                  ),
                ),
              ],
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 28, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),

      // === Drawer Navigasi ===
      drawer: Drawer(
        backgroundColor: Color(ColorCustom.ColorLight),
        child: Column(
          children: [
            const DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Admin Panel",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.home),
              title: const Text("Dashboard"),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectMenu(0),
              hoverColor: Colors.blue.shade200,
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.list),
              title: const Text("Kategori"),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectMenu(1),
              hoverColor: Colors.blue.shade200,
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.userGroup),
              title: const Text("Anggota"),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectMenu(2),
              hoverColor: Colors.blue.shade200,
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.user),
              title: const Text("User"),
              selected: _selectedIndex == 3,
              onTap: () => _onSelectMenu(3),
              hoverColor: Colors.blue.shade200,
            ),
          ],
        ),
      ),

      // === Konten Halaman ===
      body: widget.body,

      // === Footer ===
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        height: 50,
        child: const Padding(
          padding: EdgeInsets.all(1.0),
          child: Text(
            "© 2025 Manajemen Keuangan - All Rights Reserved",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
