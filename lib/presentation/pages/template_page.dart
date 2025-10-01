import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';

class TemplatePage extends StatefulWidget {
  final String title;
  final Widget body;

  const TemplatePage({super.key, required this.title, required this.body});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int _selectedIndex = 0;

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
            Container(
              child: Row(
                children: [
                  Image.asset(
                    '${PathImage.icons}icons.png',
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
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
              leading: const Icon(FontAwesomeIcons.user),
              title: const Text("User"),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectMenu(2),
              hoverColor: Colors.blue.shade200,
            ),
          ],
        ),
      ),
      body: widget.body,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
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
