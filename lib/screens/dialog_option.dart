import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../models/game_settings.dart';
import '../models/game_state.dart';
import 'display_row.dart';
import 'game.dart';

class TimerDialogOption extends StatelessWidget {
  final BuildContext dialogContext;
  final TimeLimit timeLimit;

  const TimerDialogOption({
    Key? key,
    required this.dialogContext,
    required this.timeLimit,
  }) : super(key: key);

  GameSettings get settings => GameSettings(timeLimit);

  void closeSettingsThenShowGame(BuildContext context) {
    Navigator.of(dialogContext, rootNavigator: true).pop();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordGame(gameState: GameState(settings)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        closeSettingsThenShowGame(context);
      },
      child: DialogRow(
        callback: () {
          closeSettingsThenShowGame(context);
        },
        textLeft: settings.timeLimitText,
        textRight: settings.timeLimitFormat,
      ),
    );
  }
}
