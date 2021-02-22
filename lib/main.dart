import 'package:easytalk/services/firebase/authWidget.dart';
import 'package:easytalk/services/firebase/authWidgetBuilder.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easytalk/services/firebase/authservice.dart';
import 'package:easytalk/loginscreen.dart';
import 'package:easytalk/parent/parentHomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: AuthWidgetBuilder(
            builder: (context, userSnapshot) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'TODO app',
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: AuthWidget(
                    userSnapshot: userSnapshot,
                  ),
                )));
  }
}

