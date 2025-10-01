import 'package:flutter/material.dart';
import 'package:manajemen_keuangan/presentation/pages/template_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: "User",
      body: SafeArea(child: Column()),
    );
  }
}
