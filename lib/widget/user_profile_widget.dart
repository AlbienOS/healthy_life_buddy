import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, snapshot, _) {
          var currentState = snapshot.state;
          if (currentState == CurrentState.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (currentState == CurrentState.isSuccsess) {
            final userData = snapshot.userData;
            return Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1519052537078-e6302a4968d4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Hello, ${userData?.name}",
                      style: textTheme.headline6?.apply(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
