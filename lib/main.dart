import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authservice.dart';
import 'loginscreen.dart';
import 'parenthomepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
        create: (_) =>AuthService(),
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TODO app',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AuthWidget(),
        ));
  }
}

class AuthWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final auth = Provider.of<AuthService>(context,listen:false);
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.active){
            final user = snapshot.data;
            return user != null ? ParentHomePage():MainLoginScreen()  ;
          }
          return Scaffold(
              body: Center(child: CircularProgressIndicator())
              );

        }, 
    );
  }
}
