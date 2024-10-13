import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceHeight, deviceWidth;
  double currentDifficultyLevel = 0;
  final List<String> difficultyTexts = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appTitle(),
                difficultySlider(),
                startGameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appTitle() {
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          difficultyTexts[currentDifficultyLevel.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget difficultySlider() {
    return Slider(
      min: 0,
      max: 2,
      divisions: 2,
      label: 'Difficulty',
      value: currentDifficultyLevel,
      onChanged: (value) {
        setState(() {
          currentDifficultyLevel = value;
        });
      },
    );
  }

  Widget startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              difficultyLevel:
                  difficultyTexts[currentDifficultyLevel.toInt()].toLowerCase(),
            ),
          ),
        );
      },
      color: Colors.blue,
      minWidth: deviceWidth! * 0.40,
      height: deviceHeight! * 0.06,
      child: const Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
