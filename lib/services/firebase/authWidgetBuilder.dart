import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easytalk/services/firebase/authservice.dart';

/// Used to create user-dependant objects that need to be accessible by all widgets.
/// This widget should live above the [MaterialApp].
/// See [AuthWidget], a descendant widget that consumes the snapshot generated by this builder.
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final User user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              Provider<ParentDataBaseService>(
                create: (_) => ParentDataBaseService(),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}