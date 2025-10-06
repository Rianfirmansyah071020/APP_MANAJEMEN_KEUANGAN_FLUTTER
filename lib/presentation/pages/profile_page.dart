import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/presentation/pages/template_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: "Profile",
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [Text("Profile")]),
          ),
        ),
      ),
    );
  }
}
