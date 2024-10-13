import 'package:flutter/material.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel;
  double? deviceHeight, deviceWidth;
  GamePageProvider? pageProvider;

  GamePage({super.key, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        difficultyLevel: difficultyLevel,
      ),
      child: buildUi(),
    );
  }

  Widget buildUi() {
    return Builder(builder: (context) {
      pageProvider = context.watch<GamePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: deviceHeight! * 0.05,
              ),
              child: gameUi(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget gameUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          questionText(),
          Column(
            children: [
              trueButton(),
              SizedBox(
                height: deviceHeight! * 0.01,
              ),
              falseButton()
            ],
          )
        ],
      ),
    );
  }

  Widget questionText() {
    return Text(
      pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQuestion('True');
      },
      color: Colors.green,
      minWidth: deviceWidth! * 0.60,
      height: deviceWidth! * 0.15,
      child: const Text(
        'True',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQuestion('False');
      },
      color: Colors.red,
      minWidth: deviceWidth! * 0.60,
      height: deviceWidth! * 0.15,
      child: const Text(
        'False',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
