import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuestionsByParents extends StatefulWidget {
  @override
  _QuestionsByParentsState createState() => _QuestionsByParentsState();
}

class _QuestionsByParentsState extends State<QuestionsByParents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              QuizView(
                image: Container(
                  height: 150,
                  width: 140,
                  child: Image.asset('assets/image2.png',fit: BoxFit.fill,),
                ),
                  showCorrect: true,
                  questionTag: 'Question 1',
                  questionColor: Colors.black,
                  tagColor: Colors.yellowAccent,
                  backgroundColor: Colors.white70,
                  tagBackgroundColor: Colors.red.shade300,
                  answerColor: Colors.white,
                  answerBackgroundColor: Colors.deepPurple,
                  question: 'What is the Color of the Player?',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  rightAnswer: 'Green',
                  wrongAnswers: ['Red','Yellow'],
                  onRightAnswer: ()=> print('Right!'),
                  onWrongAnswer: (){
                  Alert(
                      context: context,
                      title: 'Wrong!',
                  ).show();
                  }
              ),
              SizedBox(height: 10,),
              QuizView(
                  image: Container(
                    height: 150,
                    width: 140,
                    child: Image.asset('assets/image3.png',fit: BoxFit.fill,),
                  ),
                  showCorrect: true,
                  questionTag: 'Question 2',
                  questionColor: Colors.black,
                  tagColor: Colors.yellowAccent,
                  backgroundColor: Colors.white70,
                  tagBackgroundColor: Colors.red.shade300,
                  answerColor: Colors.white,
                  answerBackgroundColor: Colors.deepPurple,
                  question: 'What is the Color of the Player?',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  rightAnswer: 'Red',
                  wrongAnswers: ['Green','Yellow'],
                  onRightAnswer: ()=> print('Right!'),
                  onWrongAnswer: (){
                    Alert(
                      context: context,
                      title: 'Wrong!',
                    ).show();
                  })
            ],
            ),
          )
      ),
      
    );
  }
}