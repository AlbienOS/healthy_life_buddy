import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/login_page.dart';
import 'package:healthy_life_buddy/interface/user_data_registration_page.dart';
import 'package:healthy_life_buddy/widget/app_headline.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/RegistrationPage';
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                const AppHeadline(),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    "Registration",
                    style: textTheme.headline5?.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFormFieldLabel(label: 'Email'),
                      EmailTextFormField(emailController: _emailController),
                      const TextFormFieldLabel(label: 'Password'),
                      PasswordTextFormField(
                          passwordController: _passwordController),
                      const TextFormFieldLabel(label: 'Re-type Password'),
                      ReTypePasswordTextFormField(
                          retypePasswordController: _retypePasswordController,
                          passwordController: _passwordController),
                      RegistrationButton(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController),
                    ],
                  ),
                ),
                const LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReTypePasswordTextFormField extends StatelessWidget {
  const ReTypePasswordTextFormField({
    Key? key,
    required TextEditingController retypePasswordController,
    required TextEditingController passwordController,
  })  : _retypePasswordController = retypePasswordController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _retypePasswordController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val == null ||
              _retypePasswordController.text != _passwordController.text
          ? "input password tidak sama"
          : null,
      controller: _retypePasswordController,
      obscureText: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val == null || val.isEmpty ? "mohon isi form" : null,
      controller: _passwordController,
      obscureText: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val == null || !val.contains("@")
          ? "mohon masukkan email yang valid"
          : null,
      controller: _emailController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
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
              if (_formKey.currentState!.validate()) {
                try {
                  final authUser = await registration(
                      _emailController.text, _passwordController.text);
                  if (authUser != null) {
                    Navigator.pushReplacementNamed(
                        context, UserDataRegistrationPage.routeName);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Password terlalu lemah")));
                  } else if (e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Email telah terdaftar")));
                  }
                }
              }
            },
            child: Text("Daftar",
                style: textTheme.button
                    ?.apply(color: Theme.of(context).colorScheme.onPrimary)),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldLabel extends StatelessWidget {
  const TextFormFieldLabel({Key? key, required this.label}) : super(key: key);

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

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Center(
            child: Text("Sudah punya akun?",
                textAlign: TextAlign.center, style: textTheme.subtitle1),
          ),
          Center(
            child: InkWell(
              child: Text(
                "Login Sekarang!",
                textAlign: TextAlign.center,
                style: textTheme.subtitle1?.apply(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  LoginPage.routeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
