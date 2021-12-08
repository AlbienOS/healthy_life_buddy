import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/helper/navigation.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/registration_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                  child: Text(
                    "Login",
                    style: textTheme.headline5?.apply(color: onBackgroundColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'email'),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'password'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 150,
                      child: TextButton(
                        child: Text(
                          "Login",
                          style: textTheme.button?.apply(
                            color: onPrimaryColor,
                          ),
                        ),
                        onPressed: () async {
                          final loginResult = await login(
                              _emailController.text, _passwordController.text);
                          if (loginResult != null) {
                            Navigator.pushReplacementNamed(
                                context, Navigation.routeName);
                          } else {
                            print("login failed");
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Belum punya akun?",
                          textAlign: TextAlign.center,
                          style: textTheme.subtitle1
                              ?.apply(color: onBackgroundColor),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          child: Text(
                            "Daftar Sekarang!",
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1?.apply(
                                color: primaryColor,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegistrationPage();
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
