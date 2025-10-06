import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';
import 'package:manajemen_keuangan/core/database/db_helper.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:manajemen_keuangan/presentation/controllers/auth_controller.dart';
import 'package:manajemen_keuangan/presentation/controllers/users_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final userController = UsersController(); // ✅ instansiasi controller
  final authContoller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ... UI sama seperti sebelumnya
        child: Row(
          children: [
            // Bagian kiri ilustrasi tetap
            MediaQuery.of(context).size.width > 900
                ? Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            '${PathImage.backgrounds}back1.png',
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            // Bagian kanan form login
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(ColorCustom.ColorDarkDeepSkyBlue),
                      Color(ColorCustom.ColorLightDeepPurple),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.4),
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white10,
                      ),
                      height: 350,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                hintText: "Enter your email",
                                prefixIcon: Icon(FontAwesomeIcons.envelope),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                }
                                if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                                hintText: "Enter your password",
                                prefixIcon: Icon(FontAwesomeIcons.lock),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? "Password can't be empty"
                                  : null,
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 300) {
                                  // 👉 Layar kecil (HP)
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          minimumSize: const Size.fromHeight(
                                            50,
                                          ), // full width
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final email = emailController.text
                                                .trim();
                                            final password = passwordController
                                                .text
                                                .trim();

                                            final user = await authContoller
                                                .login(email, password);

                                            if (user != null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Login Berhasil",
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                              Navigator.pushNamed(
                                                context,
                                                '/dashboard',
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Email atau password salah",
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: const Text("Login"),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            7,
                                            204,
                                            188,
                                          ),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          minimumSize: const Size.fromHeight(
                                            50,
                                          ), // full width
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: const Text("Back"),
                                      ),
                                    ],
                                  );
                                } else {
                                  // 👉 Layar besar (desktop/tablet)
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          fixedSize: const Size(100, 40),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            final email = emailController.text
                                                .trim();
                                            final password = passwordController
                                                .text
                                                .trim();

                                            final user = await authContoller
                                                .login(email, password);

                                            if (user != null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Login Berhasil",
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                              Navigator.pushNamed(
                                                context,
                                                '/dashboard',
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Email atau password salah",
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: const Text("Login"),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            7,
                                            204,
                                            188,
                                          ),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          fixedSize: const Size(100, 40),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: const Text("Back"),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
