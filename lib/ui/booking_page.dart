import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_buddy/common/colors_style.dart';
import 'package:healthy_buddy/common/text_style.dart';

class BookingPage extends StatelessWidget {
  static const routeName = '/BookingPage';
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InputField(
                text: "Nama",
                inputType: TextInputType.name,
              ),
              const InputField(
                text: "Alamat",
                inputType: TextInputType.streetAddress,
              ),
              const InputField(
                text: "Tanggal penyewaan",
                inputType: TextInputType.datetime,
              ),
              const InputField(
                text: "Durasi",
                inputType: TextInputType.number,
              ),
              const InputField(
                text: "Kode promosi",
                inputType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Harga total : Rp 40.000",
                  style: textTheme.headline6?.apply(color: onBackgroundColor),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Bayar",
                      style:
                          textTheme.button?.apply(color: onPrimaryVariantColor),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: primaryVariantColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.text,
    required this.inputType,
  }) : super(key: key);

  final String text;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              text,
              style: textTheme.subtitle1?.apply(color: onBackgroundColor),
            ),
          ),
          TextField(
            keyboardType: inputType,
            decoration: InputDecoration(
              filled: true,
              fillColor: surfaceColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
