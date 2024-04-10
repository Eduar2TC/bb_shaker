import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:baby_shaker/Utils/audio_manager.dart';
import 'package:baby_shaker/pages/custom_widgets/custom_layout_builder.dart';
import 'package:baby_shaker/pages/custom_widgets/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stopwatch? stopwatch;
  Timer? timer;
  ShakeDetector? detector;
  bool btnActive = true;
  int? limitShakes;
  String btnText = 'Play';
  int shakeCounter = 0;
  bool gameOver = false;
  //items
  late List<List<Widget>> widgets;
  late int? randomItem;
  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = setupTimer();
    detector = setupShakeDetector();
    limitShakes = getRandomShakeLimit();
    //items
    initItems();
  }

  void initItems() {
    widgets = [
      [const CustomLayoutBuilder(imagePath: 'lib/assets/images/bb00.jpeg')],
      [const CustomLayoutBuilder(imagePath: 'lib/assets/images/bb01.jpeg')],
      [const CustomLayoutBuilder(imagePath: 'lib/assets/images/bb02.jpeg')],
      [const CustomLayoutBuilder(imagePath: 'lib/assets/images/bb03.jpeg')],
    ];
    randomItem = math.Random().nextInt(widgets.length);
  }

  Timer setupTimer() {
    return Timer.periodic(
      const Duration(milliseconds: 30),
      (Timer t) {
        setState(() {});
      },
    );
  }

  ShakeDetector setupShakeDetector() {
    return ShakeDetector.waitForStart(
      onPhoneShake: handleShake,
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 1.7,
    );
  }

  void handleShake() {
    if (shakeCounter < limitShakes!) {
      setState(() {
        ++shakeCounter;
        log('counter: $shakeCounter limit: $limitShakes');
      });
    } else if (shakeCounter == limitShakes!) {
      log('Game Over');
      setState(() {
        detector?.stopListening();
        handleStopWatch();
        shakeCounter = 0;
        btnActive = true;
        btnText = 'Play Again';
        gameOver = true;
        AudioManager().stopAudio();
        AudioManager().playAudio('dth.mp3');
      });
    }
  }

  int getRandomShakeLimit() {
    const int min = 1;
    const int max = 5;
    return min + math.Random().nextInt((max + 1) - min);
  }

  void handleStopWatch() {
    if (stopwatch!.isRunning) {
      stopwatch!.stop();
    } else {
      stopwatch!.reset();
      stopwatch!.start();
    }
  }

  String returnTime() {
    final int milliseconds = stopwatch!.elapsedMilliseconds;
    final int hundreds = (milliseconds / 10).truncate();
    final int seconds = (hundreds / 100).truncate();
    final int minutes = (seconds / 60).truncate();
    String twoDigitMinutes = minutes.remainder(60).toString().padLeft(2, '0');
    String twoDigitSeconds = seconds.remainder(60).toString().padLeft(2, '0');
    String twoDigitHundreds =
        hundreds.remainder(100).toString().padLeft(2, '0');

    return '$twoDigitMinutes:$twoDigitSeconds:$twoDigitHundreds';
  }

  void playGame() {
    setState(() {
      handleStopWatch();
      detector?.startListening();
      btnActive = false;
      btnText = 'Playing';
      gameOver = false;
      limitShakes = getRandomShakeLimit();
      randomItem = math.Random().nextInt(widgets.length);
      AudioManager().playAudio('sound0.mp3');
    });
  }

  List<Widget> createWidgetGroup() {
    List<Widget> widgetGroup = List.from(widgets[randomItem!]);
    Map<int, List> positionedWidgets = {
      0: [
        Positioned(
          top: 250,
          left: 150,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
        Positioned(
          top: 250,
          left: 250,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
      ],
      1: [
        Positioned(
          top: 250,
          left: 200,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
        Positioned(
          top: 280,
          left: 350,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
      ],
      2: [
        Positioned(
          top: 260,
          left: 100,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
        Positioned(
          top: 260,
          left: 240,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
      ],
      3: [
        Positioned(
          top: 300,
          left: 50,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
        Positioned(
          top: 280,
          left: 200,
          child: CustomPaint(
            painter: BrushStrokeXPainter(),
            size: const Size(50, 50),
          ),
        ),
      ],
    };
    if (gameOver) {
      widgetGroup.add(
        positionedWidgets[randomItem!]?[0],
      );
      widgetGroup.add(
        positionedWidgets[randomItem!]?[1],
      );
    }
    return widgetGroup;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildTimerContainer(width, height),
              buildGameContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTimerContainer(double width, double height) {
    return Container(
      width: width,
      height: height * 0.1,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Text(
          returnTime(),
          style: const TextStyle(
            color: Colors.white,
            //bigger font size from context
            fontSize: 45.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Expanded buildGameContainer() {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ...createWidgetGroup(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildPlayButton(),
          ),
        ],
      ),
    );
  }

  SizedBox buildPlayButton() {
    return SizedBox(
      height: 60.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              btnActive ? Theme.of(context).colorScheme.primary : Colors.grey,
          foregroundColor: Colors.black,
        ),
        onPressed: btnActive ? playGame : null,
        child: Text(
          btnText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
