import 'package:flutter/material.dart';
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
    return Consumer<AuthProvider>(
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
                Icon(
                  Icons.account_circle,
                  size: 36.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Hello, ${userData?.name}",
                    style: textTheme.headline6?.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(child: Text("Error"));
        }
      },
    );
  }
}
