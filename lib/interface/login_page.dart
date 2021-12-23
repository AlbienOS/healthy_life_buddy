import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/interface/registration_page.dart';
import 'package:healthy_life_buddy/provider/auth_provider.dart';
import 'package:healthy_life_buddy/widget/app_headline.dart';
import 'package:provider/provider.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                const AppHeadline(),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    "Login",
                    style: textTheme.headline5?.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const TextFieldLabel(label: 'Email'),
                EmailTextField(emailController: _emailController),
                const TextFieldLabel(label: 'Password'),
                PasswordTextField(passwordController: _passwordController),
                LoginButton(
                    emailController: _emailController,
                    passwordController: _passwordController),
                const RegistrationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              final loginResult = await Provider.of<AuthProvider>(context,
                      listen: false)
                  .loginUser(_emailController.text, _passwordController.text);
              if (loginResult != null) {
                Navigator.pushReplacementNamed(context, Navigation.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Email atau password salah",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Login",
                style: textTheme.button
                    ?.apply(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 3.0),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 3.0),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Center(
            child: Text("Belum memiliki akun?",
                textAlign: TextAlign.center,
                style: textTheme.subtitle1
                    ?.apply(color: Theme.of(context).colorScheme.onBackground)),
          ),
          Center(
            child: InkWell(
              child: Text(
                "Daftar Sekarang",
                textAlign: TextAlign.center,
                style: textTheme.subtitle1?.apply(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RegistrationPage.routeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        label,
        style: textTheme.subtitle1
            ?.apply(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
