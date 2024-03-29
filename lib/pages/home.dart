import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

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
  int shakeCounter = 0; //TODO: Refact this line
  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(
      const Duration(milliseconds: 30),
      (Timer t) {
        setState(() {});
      },
    );
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        /*ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );*/
        // Do stuff on phone shake
        //set random limit Shakes between 1-5
        const int min = 1;
        const int max = 5;
        limitShakes = (min + math.Random().nextInt((max + 1) - min));
        if (shakeCounter < limitShakes!) {
          setState(() {
            shakeCounter++;
            log(shakeCounter.toString());
          });
        } else if (shakeCounter == limitShakes!) {
          setState(() {
            detector?.stopListening();
            handleStopWatch();
            shakeCounter = 0;
            btnActive = true;
            btnText = 'Play Again';
          });
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 1.7,
    );
  }

  void handleStopWatch() {
    if (stopwatch!.isRunning) {
      stopwatch!.stop();
    } else {
      stopwatch!.start();
    }
  }

  String returnTime() {
    final int milliseconds = stopwatch!.elapsedMilliseconds;
    final int hundreds = (milliseconds / 10).truncate();
    final int seconds = (hundreds / 100).truncate();
    final int minutes = (seconds / 60).truncate();
    return '${minutes % 60}:${seconds % 60}:${hundreds % 100}';
  }

  void playGame() {
    handleStopWatch();
    detector?.startListening();
    btnActive = false;
    btnText = 'Playing';
  }

  @override
  Widget build(BuildContext context) {
    //get height and width screen size
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          //get color scheme
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Add this
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width,
                height: height * 0.1,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    returnTime(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(
                      image: const AssetImage(
                        'lib/assets/images/bb01.jpeg',
                      ),
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    //TextButton width = 100% play again text
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 70.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: btnActive
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: btnActive
                              ? () {
                                  playGame();
                                }
                              : null,
                          child: Text(
                            btnText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
