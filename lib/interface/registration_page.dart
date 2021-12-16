import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/login_page.dart';
import 'package:healthy_life_buddy/interface/user_data_registration_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Healthy Life \nBuddy',
                    style: textTheme.headline5?.apply(color: primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text("Registration", style: textTheme.headline5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'email'),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'password'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: _retypePasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 're-type password'),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: TextButton(
                      child: Text("Lanjut", style: textTheme.button),
                      onPressed: () async {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text ==
                                _retypePasswordController.text) {
                          final authUser = await registration(
                              _emailController.text, _passwordController.text);
                          if (authUser != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const UserDataRegistrationPage();
                                },
                              ),
                            );
                          }
                        } else {}
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text("Sudah punya akun?",
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1),
                      ),
                      Center(
                        child: InkWell(
                          child: Text(
                            "Login Sekarang!",
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1
                                ?.apply(decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginPage();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
