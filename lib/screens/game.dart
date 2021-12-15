import 'dart:async';

import 'package:flutter/material.dart';

import '../manager/padding.dart';
import '../manager/size.dart';
import '../models/game_state.dart';
import 'display_row.dart';

class WordGame extends StatefulWidget {
  final GameState gameState;

  const WordGame({Key? key, required this.gameState}) : super(key: key);

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  final stopwatch = Stopwatch();
  late Timer timer;

  String get remainingSeconds => widget.gameState.textRemainingSeconds;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    disposeTimers();
    super.dispose();
  }

  bool get gameCanBePaused => widget.gameState.canPause && stopwatch.isRunning;

  bool get gameIsPlayable =>
      stopwatch.isRunning && widget.gameState.enoughTimeLeft;

  bool get notEnoughTimeLeft => !widget.gameState.enoughTimeLeft;

  void answer(bool value) {
    widget.gameState.addAnswer(value);
    replaceWord();
  }

  void disposeTimers() {
    stopwatch.stop();
    timer.cancel();
  }

  void replaceWord() {
    setState(() {
      widget.gameState.replaceWord();
    });
  }

  void runTimer(Timer _) {
    if (gameIsPlayable) {
      setState(() {
        widget.gameState.reduceTime();
      });
    }

    if (notEnoughTimeLeft) {
      disposeTimers();
      endGame();
    }
  }

  void endGame() {
    final eval = widget.gameState.evaluateAnswers;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final headline5 = theme.textTheme.headline5!;
        final buttonStyle = ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(headline5),
        );

        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text(
              widget.gameState.settings.results,
              textAlign: TextAlign.center,
            ),
            children: [
              Text(
                eval.percentageText,
                textAlign: TextAlign.center,
                style: theme.textTheme.headline2,
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Correct",
                  textRight: eval.correct.toString(),
                ),
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Wrong",
                  textRight: eval.wrong.toString(),
                ),
              ),
              SimpleDialogOption(
                child: DialogRow(
                  textLeft: "Total",
                  textRight: eval.total.toString(),
                ),
              ),
              const Divider(),
              SimpleDialogOption(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.replay),
                      label: const Text("REPLAY"),
                      style: buttonStyle,
                      onPressed: replayGame,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text("Home"),
                      style: buttonStyle,
                      onPressed: () {
                        final navigator =
                            Navigator.of(context, rootNavigator: true);

                        navigator.popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pauseGame() {
    if (gameCanBePaused) {
      stopwatch.stop();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final theme = Theme.of(context);
          final headline5 = theme.textTheme.headline5!;
          final buttonStyle = ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(headline5),
          );

          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              children: [
                SimpleDialogOption(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    style: buttonStyle,
                    label: const Text("Resume"),
                    onPressed: () {
                      if (!stopwatch.isRunning) {
                        Navigator.pop(context);
                        stopwatch.start();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void replayGame() {
    widget.gameState.reset();
    Navigator.pop(context);
    startGame();
  }

  void startGame() {
    const interval = Duration(seconds: 1);

    stopwatch.start();

    timer = Timer.periodic(interval, runTimer);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final theme = Theme.of(context);

    final headline5 = theme.textTheme.headline5!;
    final size = media.size;

    final gameSize = SizeManager.game(size);

    final buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(gameSize),
      textStyle: MaterialStateProperty.all<TextStyle>(headline5),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: pauseGame,
          ),
        ],
        centerTitle: true,
        title: Text(remainingSeconds),
      ),
      body: SafeArea(
        child: Padding(
          padding: PaddingManager.contents(size),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Is the word valid?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline6,
                ),
                Text(
                  widget.gameState.text,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline3,
                ),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        answer(true);
                      },
                      child: const Text("CORRECT"),
                    ),
                    if (media.orientation == Orientation.portrait)
                      const Divider(
                        color: Colors.transparent,
                      ),
                    OutlinedButton(
                      style: buttonStyle,
                      child: const Text("WRONG"),
                      onPressed: () {
                        answer(false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
