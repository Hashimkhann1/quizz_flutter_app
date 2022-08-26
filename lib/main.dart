import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzlerpage(),
          ),
        ),
      ),
    );
  }
}



class Quizzlerpage extends StatefulWidget {
  @override
  State<Quizzlerpage> createState() => _QuizzlerpageState();
}

class _QuizzlerpageState extends State<Quizzlerpage> {
  @override
  Widget build(BuildContext context) {
    return List<Icon> scoreKeeper = [];
    // List<String> question = [
    //   'You can lead a cow down stairs but not up stairs.',
    //   'Approximately one quarter of human bones are in the feet.',
    //   'A slug\'s blood is green.'
    // ];
    //
    // List<bool> answer = [true, false, false];
    //
    // Question q1 = Question(
    //     q: 'You can lead a cow down stairs but not up stairs.', a: false);


    void checkAnswer(bool userPickedAnswer){
      setState(() {
        if(quizBrain.isFinshed() == true){
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();

          quizBrain.reset();

          scoreKeeper = [];
        }
        else{
          bool currectAnswer = quizBrain.getCorrectAnswer();
          if (userPickedAnswer == currectAnswer) {
            print('user got it right');
            scoreKeeper.add(
                Icon(
                  Icons.check,
                  color: Colors.green,
                ));
          } else {
            print('user got it wrong');
            scoreKeeper.add(
                Icon(
                  Icons.close,
                  color: Colors.red,
                )
            );
          }
        }
        setState(() {
          quizBrain.nextQuestion();
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  //The user picked true.
                  checkAnswer(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //The user picked false.
                  checkAnswer(false);
                },
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
          //TODO: Add a Row here as your score keeper
        ],
      );
    };
  }
}


