import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';

enum Gender { pria, wanita }

class UserDataRegistrationPage extends StatefulWidget {
  const UserDataRegistrationPage({Key? key}) : super(key: key);

  @override
  State<UserDataRegistrationPage> createState() =>
      _UserDataRegistrationPageState();
}

class _UserDataRegistrationPageState extends State<UserDataRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  Gender? _gender;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumber.dispose();
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
                  child: Text(
                    "User Info",
                    style: textTheme.headline5?.apply(color: onBackgroundColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'nama'),
                  ),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'umur'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Gender",
                    style: textTheme.subtitle1?.apply(color: onBackgroundColor),
                  ),
                ),
                RadioListTile<Gender>(
                  title: const Text('Pria'),
                  value: Gender.pria,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                RadioListTile<Gender>(
                  title: const Text('Wanitia'),
                  value: Gender.wanita,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'tempat tinggal'),
                  ),
                ),
                TextFormField(
                  controller: _phoneNumber,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'no hp'),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: 150,
                      child: TextButton(
                        child: Text(
                          "Daftar",
                          style: textTheme.button?.apply(
                            color: onPrimaryColor,
                          ),
                        ),
                        onPressed: () async {
                          if (_nameController.text.isNotEmpty) {
                            await userDataRegistration(
                                _nameController.text,
                                int.parse(_ageController.text),
                                _gender.toString(),
                                _addressController.text,
                                _phoneNumber.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          } else {
                            print('fill the text field');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                      ),
                    ),
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
