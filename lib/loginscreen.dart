import 'dart:ui';
import 'package:easytalk/child/childHomepage.dart';
import 'package:easytalk/homepage.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easytalk/services/firebase/authservice.dart';

class MainLoginScreen extends StatefulWidget {
  @override
  _MainLoginScreenState createState() => _MainLoginScreenState();
}

class _MainLoginScreenState extends State<MainLoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _registrationController =
      new TextEditingController();
  //10^(no of digit - 1)
  final int factor = 100000;
Widget navigateChildHome(value){
      return MultiProvider(
        providers: [
          Provider<Child>(
            create: (_) => Child.fromJson(value.data()),
          ),
          Provider<ChildDataBaseService>(
            create: (_) =>
                ChildDataBaseService(regCode: value.data()["regCode"]),
          )
        ],
        child: ChildHomePage(),
      );
}
  Future login() {
    FocusScope.of(_scaffoldKey.currentContext).unfocus();
    var auth =
        Provider.of<AuthService>(_scaffoldKey.currentContext, listen: false);
    return auth.childSignIn(_registrationController.text);  
  }

  Widget _loginButton(size) => Material(
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
          minWidth: size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          color: Colors.purple,
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              var log = await login();
              if (log.data() != null){
                print(log.data());
                Navigator.of(_scaffoldKey.currentContext).pushReplacement(
                  MaterialPageRoute(builder: (_)=>navigateChildHome(log))
                );
              }else{
                showAlertDialog();
              }
            }
          },
          child: Text("Login",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white))));

  Widget _childSignInField() => TextFormField(
        controller: _registrationController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) {
          if (!value.isNotEmpty) {
            return "Please enter your login information";
          }
          int intval = int.parse(value) ~/ factor;
          if ((intval < 1) || (intval > 10)) {
            print(intval);
            return "The length of the code is incorrect";
          }
          return null;
        },
        onEditingComplete: () async{
          if (_formKey.currentState.validate()) {
              var log = await login();
              if (log.data() != null){
                Navigator.of(_scaffoldKey.currentContext).push(
                  MaterialPageRoute(builder: (_)=>navigateChildHome(log))
                );
              }else{
                showAlertDialog();
              }
          }
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple[200], width: 2),
            gapPadding: 5,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 2),
          ),
        ),
      );

  Widget _welcome() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.home_rounded, size: 70, color: Colors.purple),
          Text("Welcome!",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple))
        ]),
      ),
    );
  }

  Widget _loginCredentials(Size size) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Divider(height: 10),
                  Text("Enter the code given to you",
                      style: TextStyle(fontSize: 17, color: Colors.grey[800])),
                  Divider(height: 5),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                _childSignInField(),
                Divider(height: 10),
                _loginButton(size)
              ]),
            )
          ],
        ));
  }

  Widget _centerView(Size size) {
    return Container(
      child: Column(
        children: [
          _welcome(),
          _loginCredentials(size),
        ],
      ),
    );
  }

  Widget _bottomParentLoginLinker() {
    return Card(
        elevation: 10,
        color: Colors.purple,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Center(
          child: TextButton(
            child: Text("Parent Login",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentLogin()));
            },
          ),
        ));
  }

    showAlertDialog() {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Sign In Error"),
        content: Text("Failed to sign in, Check your code and Please try again."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
          onTap: () {
            var node = FocusScope.of(_scaffoldKey.currentContext);

            if (!node.hasPrimaryFocus) {
              node.unfocus();
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        _centerView(size),
                        Container(
                          height: 70,
                          child: _bottomParentLoginLinker(),
                        )
                      ],
                    ))),
          ));
    }));
  }
}

class ParentLogin extends StatefulWidget {
  ParentLogin({Key key}) : super(key: key);
  _ParentLoginState createState() => _ParentLoginState();
}

class _ParentLoginState extends State<ParentLogin> {
  bool _isSigningIn = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget circularLoadingIndicator() =>
      Center(child: CircularProgressIndicator());

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Widget build(BuildContext context) {
    showAlertDialog() {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Sign In Error"),
        content: Text("Failed to sign in, Please try again."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    void _googlesignin() async {
      final auth = Provider.of<AuthService>(context, listen: false);
      try {
        final User user = await auth.signInWithGoogle();
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage()),
          );
        }
        if (user == null) {
          showAlertDialog();
        }
      } catch (e) {
        print(e);
      }
    }

    Widget _cancelCrossButton() {
      return ListTile(
        leading: IconButton(
          icon: Icon(Icons.close, size: 30),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }

    Widget _screenInfo() {
      return Container(
          padding: EdgeInsets.only(left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Parental Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Divider(height: 10),
            Text("Login using the following",
                style: TextStyle(
                  fontSize: 20,
                ))
          ]));
    }

    Widget _signInButton(IconData icon, String text, Color color, var func) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: FlatButton(
            color: color,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
              Text(text, style: TextStyle(color: Colors.white))
            ]),
            onPressed: () {
              setState(() {
                _isSigningIn = true;
              });
              func().then((_) => setState(() {
                    _isSigningIn = false;
                  }));
            },
          ));
    }

    Widget _signUpScreen() {
      return SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Divider(height: 20),
        _cancelCrossButton(),
        Divider(height: 40),
        _screenInfo(),
        Divider(height: 40),
        _signInButton(
            FontAwesomeIcons.google,
            "Sign In with"
            " Google",
            Color(0xff4285F4),
            _googlesignin),
        Divider(height: 20),
        _signInButton(FontAwesomeIcons.facebook, "Sign In with Facebook",
            Color(0xff4267B2), null),
        Container()
      ]));
    }

    return Scaffold(
      key: _scaffoldKey,
      body: _isSigningIn ? circularLoadingIndicator() : _signUpScreen(),
    );
  }
}
