import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/widget/app_headline.dart';

class UserDataRegistrationPage extends StatefulWidget {
  static const routeName = '/UserDataRegistrationPage';
  const UserDataRegistrationPage({Key? key}) : super(key: key);

  @override
  State<UserDataRegistrationPage> createState() =>
      _UserDataRegistrationPageState();
}

class _UserDataRegistrationPageState extends State<UserDataRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _gender;
  @override
  void initState() {
    _gender = "Pria";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
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
                    "User Info",
                    style: textTheme.headline5?.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFormFieldLabel(label: 'Nama'),
                      NameTextFormField(nameController: _nameController),
                      const TextFormFieldLabel(label: 'Umur'),
                      AgeTextFormField(ageController: _ageController),
                      const TextFormFieldLabel(label: 'Gender'),
                      genderRadioButton(context),
                      const TextFormFieldLabel(label: 'Tempat Tinggal'),
                      AddressTextFormField(
                          addressController: _addressController),
                      const TextFormFieldLabel(label: 'No HP'),
                      PhoneNumberTextFormField(
                          phoneNumberController: _phoneNumberController),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: SizedBox(
                            width: 150,
                            child: TextButton(
                              child: Text(
                                "Daftar",
                                style: textTheme.button?.apply(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final result = await userDataRegistration(
                                        _nameController.text,
                                        int.parse(_ageController.text),
                                        _gender.toString(),
                                        _addressController.text,
                                        _phoneNumberController.text);
                                    if (result == "success") {
                                      Navigator.pushReplacementNamed(
                                          context, Navigation.routeName);
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Maaf terjadi kesalah",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary),
                            ),
                          ),
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

  Theme genderRadioButton(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Pria'),
            value: "Pria",
            groupValue: _gender,
            onChanged: (value) {
              setState(
                () {
                  _gender = value;
                },
              );
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          RadioListTile<String>(
            title: const Text('Wanitia'),
            value: "Wanita",
            groupValue: _gender,
            onChanged: (value) {
              setState(
                () {
                  _gender = value!;
                },
              );
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class PhoneNumberTextFormField extends StatelessWidget {
  const PhoneNumberTextFormField({
    Key? key,
    required TextEditingController phoneNumberController,
  })  : _phoneNumberController = phoneNumberController,
        super(key: key);

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) =>
          val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
      controller: _phoneNumberController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class AddressTextFormField extends StatelessWidget {
  const AddressTextFormField({
    Key? key,
    required TextEditingController addressController,
  })  : _addressController = addressController,
        super(key: key);

  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) =>
          val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
      controller: _addressController,
      keyboardType: TextInputType.streetAddress,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class AgeTextFormField extends StatelessWidget {
  const AgeTextFormField({
    Key? key,
    required TextEditingController ageController,
  })  : _ageController = ageController,
        super(key: key);

  final TextEditingController _ageController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) =>
          val == null || val == "" || int.parse(_ageController.text) < 0
              ? "Umur yang dimasukkan tidak valid"
              : null,
      controller: _ageController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val == null || val == "" || val.length > 12
          ? "Jumlah karakter yang dimasukkan harus 1 ~ 16 karakter"
          : null,
      controller: _nameController,
      keyboardType: TextInputType.name,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: textTheme.caption
            ?.apply(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class TextFormFieldLabel extends StatelessWidget {
  const TextFormFieldLabel({
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
