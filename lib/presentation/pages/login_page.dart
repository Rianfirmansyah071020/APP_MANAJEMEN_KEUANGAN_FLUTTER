import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/PathImage.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Map<String, String> dummyAkun = {'rian071020@gmail.com': '1234'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 250, 250, 250),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            MediaQuery.of(context).size.width > 900
                ? Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Colors.white10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ayo Kelola Keuangan Mu',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Dengan Aplikasi Manajemen Keuangan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Image.asset(
                                '${PathImage.backgrounds}back1.png',
                                fit: BoxFit.cover,
                                width: 500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(), // kosong kalau layar kecil

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
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                suffixIconColor: Colors.white,
                                labelText: "Email",
                                hintText: "Enter your email",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 175),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 175),
                                ),
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(FontAwesomeIcons.envelope),
                                border: OutlineInputBorder(),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                }
                                if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
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
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 175),
                                ),
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(FontAwesomeIcons.lock),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 175),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? "Password can't be empty"
                                  : null,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: const Color.fromARGB(
                                      255,
                                      236,
                                      236,
                                      236,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fixedSize: const Size(100, 40),
                                  ),
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;

                                    if (formKey.currentState!.validate()) {
                                      if (dummyAkun.containsKey(email) &&
                                          dummyAkun[email] == password) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Login Berhasil"),
                                            duration: Duration(seconds: 2),
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
                                            content: Text("Login Gagal"),
                                            duration: Duration(seconds: 2),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fixedSize: const Size(100, 40),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Back"),
                                ),
                              ],
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
