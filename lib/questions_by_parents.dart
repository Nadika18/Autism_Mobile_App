import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class QuestionsByParents extends StatefulWidget {
  @override
  _QuestionsByParentsState createState() => _QuestionsByParentsState();
}

class _QuestionsByParentsState extends State<QuestionsByParents> {
  Widget Quizquestion(String _questionno, String _imagepath, String _question,String _option1, String _option2,String _option3,String _option4){
    return QuizView(
                image: Container(
                  height: 150,
                  width: 140,
                  child: Image.asset(_imagepath,fit: BoxFit.fill,),
                ),
                  showCorrect: true,
                  questionTag: _questionno,
                 
                  questionColor: Colors.black,
                  
                  backgroundColor: Colors.white70,
                 
                  answerColor: Colors.white,
                  answerBackgroundColor: Colors.deepPurple,
                  question: _question,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  rightAnswer: _option1,
                  wrongAnswers: [_option2,_option3, _option4],
                  onRightAnswer: ()=> print('Right!'),
                  onWrongAnswer: (){
                  Alert(
                      context: context,
                      title: 'Wrong!',
                  ).show();
                  }
              );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Divider(), 
              Quizquestion('1', 'assets/apple.jpg', 'Which fruit is this?' , "Apple", "Banana", "Orange", "Mango"),
              Divider(),
            Quizquestion('2', 'assets/banana.jpg', 'Which fruit is this?' , "Banana", "Apple", "Orange", "Mango")

              
              
              
            ],
            ),
          )
      ),
      
    );
  }
}