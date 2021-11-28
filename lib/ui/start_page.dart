import 'package:flutter/material.dart';
import 'package:healthy_buddy/common/colors_style.dart';
import 'package:healthy_buddy/common/navigation.dart';
import 'package:healthy_buddy/common/text_style.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);
  static const routeName = '/StartPage';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Healthy Life \nBuddy',
                style: textTheme.headline5?.apply(color: primaryColor),
              ),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 64),
                        child: Icon(
                          Icons.sports_basketball,
                          size: 150,
                          color: primaryColor,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Cari & pesan tempat olahraga \ndi ',
                              style: textTheme.headline5
                                  ?.apply(color: onBackgroundColor),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Healthy Life Buddy',
                                    style: textTheme.headline5
                                        ?.apply(color: primaryColor)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Kamu dapat mencari dan memesan \ntempat olahraga sesuai keinginan \ndan kebutuhanmu di sini',
                              style: textTheme.subtitle1
                                  ?.apply(color: onBackgroundColor),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: SizedBox(
                          width: 175,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Navigation.routeName);
                            },
                            child: Text(
                              "Mulai Olahraga",
                              textAlign: TextAlign.center,
                              style: textTheme.button,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
