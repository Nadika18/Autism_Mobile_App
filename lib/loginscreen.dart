import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLoginScreen extends StatefulWidget{
  @override
  _MainLoginScreenState createState() => _MainLoginScreenState();
}

class _MainLoginScreenState extends State<MainLoginScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _registrationController = new
      TextEditingController();
  //10^(no of digit - 1)
  final int factor = 100000;
  Widget _loginButton(size) => Material(
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
          minWidth: size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          color: Colors.purple,
          onPressed: () {
            if(!_formKey.currentState.validate()){
              //TODO:go to other screen
            }
            print("this is tapped");
          },
          child: Text("Login",
                     textAlign: TextAlign.center,
                     style: TextStyle(color: Colors.white)
                 )));

  Widget _childSignInField() => TextFormField(
      controller: _registrationController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
        validator: (value){
          if(!value.isNotEmpty){
            return "Please enter your login information";
          } 
          int intval = int.parse(value)~/factor;
          if ((intval < 1) || (intval> 10)){
            print(intval);
            return "The length of the code is incorrect";
          }
          return null;
        },
        onEditingComplete: (){
          if(_formKey.currentState.validate()){
            print("completed filling");
            FocusScope.of(_scaffoldKey.currentContext).unfocus();
            //TODO:go to other screen
          }
        },
  decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.purple[200],width: 2),
                      gapPadding: 5,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.grey[400],width: 2),
                  ),
              ),
  );

  Widget _welcome(){
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: EdgeInsets.fromLTRB(10,0,0,5),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.home_rounded,
                      size:70,color: Colors.purple),
                  Text("Welcome!",
                      style: TextStyle(fontSize: 50,
                          fontWeight:FontWeight.bold,
                          color: Colors.purple))
                ]

            ),),
    );
  }

  Widget _loginCredentials(Size size){
    return  Container(
        padding: EdgeInsets.all(10),
        child:Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                            style: TextStyle(fontSize: 30,
                                fontWeight:FontWeight.bold,
                                color: Colors.black)),
                        Divider(height:10),

                        Text("Enter the code given to you",
                            style: TextStyle(fontSize: 17,
                                color: Colors.grey[800])),
                        Divider(height:5),
                      ],
                  ),
              ),
              Form(
                  key: _formKey,
                  child:Column(
                      children:[
                        _childSignInField(),
                        Divider(height:10),
                        _loginButton(size)
                      ]
                  ),
              )
                  ],
                  ));
  }

  Widget _centerView(Size size){
    return Container(
        child: Column(
            children: [
              _welcome(),
              _loginCredentials(size),
            ],
        ),
    );
  }
  Widget _bottomParentLoginLinker(){
    return  Card(
        elevation: 20,
        margin: EdgeInsets.symmetric(horizontal:0,vertical:0),
        child:Center(
            child: TextButton(
                child: Text("Parent Login"),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> ParentLogin())
                  );
                },
            ),
        ));
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: LayoutBuilder(
            builder: (context,constraints){
              return GestureDetector(
                  onTap: (){
                    var node = FocusScope.of(_scaffoldKey.currentContext);

                    if(!node.hasPrimaryFocus){
                      node.unfocus();
                    }
                  },
                  child:Scaffold(               
                            key: _scaffoldKey,
                            body: SingleChildScrollView(
                                child:Container(
                                    height: constraints.maxHeight,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          _centerView(size),
                                          _bottomParentLoginLinker(),
                                        ],
                                    )
                                )
                            ),

                        )
                      );
            }
    )
        );
  }
}

class ParentLogin extends StatefulWidget{
  ParentLogin({Key key}):super(key: key);
  _ParentLoginState createState() => _ParentLoginState();
}

class _ParentLoginState extends State<ParentLogin>{
  Widget build(BuildContext context){
    return Scaffold(
        body: SafeArea(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(height:20),
                  ListTile(
                      leading: IconButton(
                          icon:Icon(Icons.close,size: 30),
                          color: Colors.black,
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          ),
                  ),
                  Divider(height:30),
                  Container(
                      padding: EdgeInsets.only(left:20),
                      child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Parental Login",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                )
                            ),
                  Divider(height:10),
                        Text("Login using the following",
                            style: TextStyle(
                                fontSize: 20,
                                )
                            )
                      ]
                      )),
                  Divider(height:20),
                  Container(
                      padding: EdgeInsets.fromLTRB(15,20,15,20),
                      child: FlatButton(
                          color: Color(0xff4285F4),
                      padding: EdgeInsets.fromLTRB(0,20,0,20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.google,color:Colors.white),
                                SizedBox(width: 10),
                                Text("Sign In with Google",style:
                                    TextStyle(color:Colors.white))
                              ]
                              ),
                          onPressed: () {
                          },
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(15,0,15,0),
                      child: FlatButton(
                          color: Color(0xff4267B2),
                      padding: EdgeInsets.fromLTRB(0,20,0,20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.facebook,color:
                                    Colors.white),
                                SizedBox(width: 10),
                                Text("Sign In with Facebook",style:
                                    TextStyle(color:Colors.white))
                              ]
                              ),
                          onPressed: () {
                          },
                      )),
                  Container()
                ]
            ))
    );
  }
}
