import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateQuestion extends StatefulWidget {
  
  @override
  _CreateQuestionState createState() => _CreateQuestionState();
  
}

class _CreateQuestionState extends State<CreateQuestion> {
  bool isLoading = false;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  String _question;
  String _option1;
  String _option2;
  String _option3;
  String _option4;
  

 

  final GlobalKey<FormState> _formkey = GlobalKey();
  Widget _buildQuestion(){
    
    return Material(
      child: TextFormField(
      decoration: InputDecoration(
        labelText: "What is the question?"),
        validator: (String value){
          if(value.isEmpty){
            return "Question is Required";
          }
          return null;
        } ,
        onSaved: (String value){
          _question = value;
        }, 
      ));
    
  }

  Widget _buildOption1(){
    return Material(
      child: TextFormField(
      decoration: InputDecoration(
        labelText: "Option 1"),
        validator: (String value){
          if(value.isEmpty){
            return "Option is Required";
          }
          return null;
        } ,
        onSaved: (String value){
          _option1 = value;
        }, 
      ));
  }

  Widget _buildOption2(){
    return Material(
      child: TextFormField(
      decoration: InputDecoration(
        labelText: "Option 2"),
        validator: (String value){
          if(value.isEmpty){
            return "Option is Required";
          }
          return null;
        } ,
        onSaved: (String value){
          _option2 = value;
        }, 
      ));
  }

  Widget _buildOption3(){
    return Material(
      child: TextFormField(
      decoration: InputDecoration(
        labelText: "Option 3"),
        validator: (String value){
          if(value.isEmpty){
            return "Option is Required";
          }
          return null;
        } ,
        onSaved: (String value){
          _option3 = value;
        }, 
      ));
  }

  Widget _buildOption4(){
    return Material(
      child: TextFormField(
      decoration: InputDecoration(
        labelText: "Option 4"),
        validator: (String value){
          if(value.isEmpty){
            return "Option is Required";
          }
          return null;
        } ,
        onSaved: (String value){
          _option4 = value;
        }, 
      ));
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.keyboard_arrow_left_sharp , 
          color: Colors.black, size: 45), 
        onPressed: (){
            Navigator.of(context).pop();
        }),
        backgroundColor: Colors.white, 
        title: Text("Questions", style: TextStyle(color: Colors.black),),),
      body: Container(
        
        padding: EdgeInsets.all(10),
      child: Form(
        key: _formkey,
        child: Column(
          
          children: [
            ListTile(title: _buildQuestion()),
            Divider(color: Colors.white),
            Container(child: Column(children: [
              ListTile(title:Align(alignment: Alignment.centerLeft, child: Text("Options", style: TextStyle(color: Colors.black),))),
              
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title:_buildOption1(), 
                      trailing:OutlineButton(
                        borderSide: BorderSide(color: Colors.blue[300]),
                        textColor: Colors.blue[300],
                        
                        child: Text("+ Add Image "),
                        onPressed: (){getImage();})),
                        ListTile(
                      title:_buildOption2(), 
                      trailing:OutlineButton(
                        borderSide: BorderSide(color: Colors.blue[300]),
                        textColor: Colors.blue[300],
                        
                        child: Text("+ Add Image "),
                        onPressed: (){getImage();})),
                        ListTile(
                      title:_buildOption3(), 
                      trailing:OutlineButton(
                        borderSide: BorderSide(color: Colors.blue[300]),
                        textColor: Colors.blue[300],
                        
                        child: Text("+ Add Image "),
                        onPressed: (){getImage();})),
                        ListTile(
                      title:_buildOption4(), 
                      trailing:OutlineButton(
                        borderSide: BorderSide(color: Colors.blue[300]),
                        textColor: Colors.blue[300],
                        
                        child: Text("+ Add Image "),
                        onPressed: (){getImage();})),
           ],),)],)  )
           ,
           Divider(color: Colors.white),
           CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: IconButton(
              icon:Icon(Icons.done, color: Colors.white,),
              
            onPressed: (){
              if(!_formkey.currentState.validate()){
                return;
              }
              _formkey.currentState.save();
              print(_question);
              print(_option1);
              print(_option2);
              print(_option3);
              print(_option4);
              print(_image);
              
              Map<String, String> questionMap = {
        "question": _question,
        "option1": _option1,
        "option2": _option2,
        "option3": _option3,
        "option4": _option4
      };
                          
            })
              ),
              ])
        )
      
    ));
  }
}