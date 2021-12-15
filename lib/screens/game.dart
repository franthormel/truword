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
  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  void answer(bool answer) {
    widget.gameState.addAnswer(answer);

    setState(() {
      widget.gameState.regenerateWord();
    });
  }

  Widget buttons() {
    final media = MediaQuery.of(context);
    final style = ButtonStyle(
      minimumSize:
      MaterialStateProperty.all<Size>(SizeManager.game(media.size)),
      textStyle: MaterialStateProperty.all<TextStyle>(
          Theme.of(context).textTheme.headline5!),
    );

    return Column(
      children: <Widget>[
        ElevatedButton(
          style: style,
          onPressed: stopwatch.isRunning
              ? () {
            answer(true);
          }
              : null,
          child: const Text("CORRECT"),
        ),
        if (media.orientation == Orientation.portrait)
          const Divider(
            color: Colors.transparent,
          ),
        OutlinedButton(
          style: style,
          child: const Text("WRONG"),
          onPressed: stopwatch.isRunning
              ? () {
            answer(false);
          }
              : null,
        ),
      ],
    );
  }

  void end() {
    final eval = widget.gameState.evaluateAnswers;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final style = ButtonStyle(
          textStyle:
          MaterialStateProperty.all<TextStyle>(theme.textTheme.headline5!),
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
                      style: style,
                      onPressed: () {
                        start(isReplay: true);
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text("Home"),
                      style: style,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .popUntil((route) => route.isFirst);
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

  void pause() {
    if (widget.gameState.canPause && stopwatch.isRunning) {
      stopwatch.stop();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final style = ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                Theme.of(context).textTheme.headline5!),
          );

          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              children: [
                SimpleDialogOption(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    style: style,
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

  void start({bool isReplay = false}) {
    if (isReplay) {
      widget.gameState.reset();
      Navigator.pop(context);
    } else {
      stopwatch = Stopwatch();
    }

    stopwatch.start();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (stopwatch.isRunning && widget.gameState.enoughTimeLeft) {
        setState(() {
          widget.gameState.reduceTime();
        });
      }

      //Stopwatch has hit the set time limit
      if (!widget.gameState.enoughTimeLeft) {
        //Stop the timer and stopwatch
        stopwatch.stop();
        timer.cancel();

        //Display popup
        end();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controls = buttons();
    final size = MediaQuery.of(context).size;
    final padding = PaddingManager.contents(size);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: stopwatch.isRunning ? pause : null,
          ),
        ],
        centerTitle: true,
        title: Text(widget.gameState.textRemainingSeconds),
      ),
      body: SafeArea(
        child: Padding(
          padding: padding,
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
                controls,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
